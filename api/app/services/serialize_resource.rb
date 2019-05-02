# serializes an Active Record resources as RDF
class SerializeResource
  PREFIXES = {
    tol:  "http://api.treasuryoflives.org/resource/",  
    bdr:  "http://purl.bdrc.io/resource/",
    bdo:  "http://purl.bdrc.io/ontology/core/",
    owl:  "http://www.w3.org/2002/07/owl#",
    rdfs: "http://www.w3.org/2000/01/rdf-schema#",
    adm:  "http://purl.bdrc.io/ontology/admin/",
    xsd:  "http://www.w3.org/2001/XMLSchema#"
  }

  LANGUAGE_CODES = {
    'russian': '',
    'japanese': '',
    'french': '',
    'mongolian': 'mg-x-poppe-simpl',
    'chinese': '' 
  }

  def initialize(person, type)
    @person = person
    @type = type
    @graph = RDF::Graph.new
    @person_uri = uri(:tol, "TOLP#{@person.person_id}")
  end

  def write_jsonld
    compacted = nil

    # context can't have symbols
    context = PREFIXES.stringify_keys

    JSON::LD::API::fromRdf(@graph) do |expanded|
      compacted = JSON::LD::API.compact(expanded, context)
    end
  end

  def write_rdfxml
    RDF::RDFXML::Writer.buffer(prefixes: PREFIXES) do |writer|
      @graph.each_statement do |statement|
        writer << statement
      end
    end
  end

  def write_turtle
    RDF::Turtle::Writer.buffer(prefixes: PREFIXES) do |writer|
      @graph.each_statement do |statement|
        writer << statement
      end
    end
  end

  def serialize
    add_triples
    
    case @type
    when :ttl
      write_turtle
    when :jsonld, :json
      write_jsonld
    when :rdf, :xml
      write_rdfxml
    end
  end

  private

  def create_uri(prefix, name)
    PREFIXES[prefix] + name
  end

  def add_triples
    add_type
    add_bdr_link unless @person.tbrc_rid.blank?
    add_default_name unless @person.default_name.blank?
    add_default_title unless @person.default_title.blank?
    add_other_names # case when none are available handled in this method
    add_gender unless @person.gender.blank?
    add_birth unless @person.birth_year.blank?
    add_death unless @person.death_year.blank?
    add_har_url unless @person.har_url.blank?
  end

  def add_type
    @graph << [
      @person_uri,
      RDF.type,
      uri(:bdo, 'Person')
    ]
  end

  def add_bdr_link
    @graph << [
      @person_uri,
      RDF::OWL.sameAs,
      uri(:bdr, @person.tbrc_rid)
    ]
  end

  def add_default_name
    blank_node = RDF::Node.new
    @graph << [
      @person_uri,
      uri(:bdo, "personName"),
      blank_node
    ]
    @graph << [
      blank_node,
      RDF::RDFS.label,
      RDF::Literal.new(@person.default_name)
    ]
    @graph << [
      blank_node,
      RDF.type,
      uri(:bdo, 'PersonPrimaryName'),
    ]
  end

  def add_other_names
    return if @person.wylie_name.blank? && 
              @person.published_default_name.blank? && 
              @person.published_wylie_name.blank? && 
              @person.name_variants.empty? 

    blank_node = RDF::Node.new
    @graph << [
      @person_uri,
      uri(:bdo, 'personName'),
      blank_node
    ]

    @graph << [
      blank_node,
      RDF.type,
      uri(:bdo, 'PersonOtherName')
    ]

    @graph << [
      blank_node,
      RDF::RDFS.label,
      RDF::Literal.new(@person.wylie_name, :language => 'bo-x-ewts')
    ]

    @graph << [
      blank_node,
      RDF::RDFS.label,
      RDF::Literal.new(@person.published_default_name)
    ]

    @graph << [
      blank_node,
      RDF::RDFS.label,
      RDF::Literal.new(@person.published_wylie_name, :language => 'bo-x-ewts')
    ]
    
    @person.name_variants.each do |name_variant|
      language = language_code(name_variant.encoding_type)
      literal = language ? 
        RDF::Literal.new(name_variant.name_variant_text, :language => language) :
        RDF::Literal.new(name_variant.name_variant_text)
      @graph << [
        blank_node,
        RDF::RDFS.label,
        literal
      ]
    end
  end

  def add_default_title
    blank_node = RDF::Node.new
    @graph << [
      @person_uri,
      uri(:bdo, "personName"),
      blank_node
    ]
    @graph << [
      blank_node,
      RDF::RDFS.label,
      @person.default_title
    ]
    @graph << [
      blank_node,
      RDF.type,
      uri(:bdo, 'PersonPrimaryTitle')
    ]
  end

  def add_gender
    @graph << [
      @person_uri,
      uri(:bdo, "personGender"),
      uri(:bdr, "GenderMale")
    ]
  end

  def add_birth
    blank_node = RDF::Node.new
    @graph << [
      @person_uri,
      uri(:bdo, "personEvent"),
      blank_node
    ]
    @graph << [
      blank_node,
      uri(:bdo, "onYear"),
      @person.birth_year
    ]
    @graph << [
      blank_node,
      RDF.type,
      uri(:bdo, "PersonBirth")
    ]
  end

  def add_death
    blank_node = RDF::Node.new
    @graph << [
      @person_uri,
      uri(:bdo, "personEvent"),
      blank_node
    ]
    @graph << [
      blank_node,
      uri(:bdo, "onYear"),
      @person.death_year
    ]
    @graph << [
      blank_node,
      RDF.type,
      uri(:bdo, "PersonDeath")
    ]
  end

  def add_har_url
    @graph << [
      @person_uri,
      uri(:adm, "seeOtherHA"),
      RDF::Literal::AnyURI.new(@person.har_url)
    ]
  end

  def uri(prefix, name)
    RDF::URI(create_uri(prefix, name))
  end

  def language_code(encoding_type)
    return nil if encoding_type.nil?

    case  encoding_type.encoding_type_key
    when 'extendedWylie' 
      'bo-x-ewts'
    else
      nil
    end
  end
end
