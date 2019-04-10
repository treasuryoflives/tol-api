# serializes an Active Record resources as RDF
class SerializeResource
  PREFIXES = {
    tol: "http://api.treasuryoflives.org/resource/",  
    bdr: "http://purl.bdrc.io/resource/",
    bdo: "http://purl.bdrc.io/ontology/core/",
    owl: "http://www.w3.org/2002/07/owl#",
    rdfs: "http://www.w3.org/2000/01/rdf-schema#"
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
    @person_uri = resource(:tol, "P#{@person.person_id}")
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
    when :turtle
      write_turtle
    when :jsonld
      write_jsonld
    when :rdfxml
      write_rdfxml
    end
  end

  private

  def create_resource(prefix, name)
    PREFIXES[prefix] + name
  end

  def person_id
    "P#{@person.person_id}"
  end

  def add_triples
    add_type
    add_bdr_link
    add_default_name
    add_other_names
    add_gender
    add_birth
    add_death
  end

  def add_type
    @graph << [
      @person_uri,
      RDF.type,
      resource(:bdo, 'Person')
    ]
  end

  def add_bdr_link
    @graph << [
      @person_uri,
      RDF::OWL.sameAs,
      resource(:bdr, @person.tbrc_rid)
    ]
  end

  def add_default_name
    blank_node = RDF::Node.new
    @graph << [
      @person_uri,
      resource(:bdo, "personName"),
      blank_node
    ]
    @graph << [
      blank_node,
      RDF::RDFS.label,
      RDF::Literal.new(@person.default_name, :language => 'bo-x-phon-en')
    ]
    @graph << [
      blank_node,
      RDF.type,
      resource(:bdo, 'PersonPrimaryName'),
    ]
  end

  def add_other_names
    blank_node = RDF::Node.new
    @graph << [
      @person_uri,
      resource(:bdo, 'personName'),
      blank_node
    ]

    @graph << [
      blank_node,
      RDF.type,
      resource(:bdo, 'PersonOtherName')
    ]

    @graph << [
      blank_node,
      RDF::RDFS.label,
      RDF::Literal.new(@person.wylie_name, :language => 'bo-x-ewts')
    ]
    
    @person.name_variants.each do |name_variant|
      @graph << [
        blank_node,
        RDF::RDFS.label,
        RDF::Literal.new(name_variant.name_variant_text, :language => 'bo-x-ewts')
      ]
    end
  end

  def add_default_title
    blank_node = RDF::Node.new
    @graph << [
      @person_uri,
      resource(:bdo, "personName"),
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
      resource(:bdo, 'PersonPrimaryTitle')
    ]
  end

  def add_gender
    @graph << [
      @person_uri,
      resource(:bdo, "personGender"),
      resource(:bdr, "GenderMale")
    ]
  end

  def add_birth
    blank_node = RDF::Node.new
    @graph << [
      @person_uri,
      resource(:bdo, "personEvent"),
      blank_node
    ]
    @graph << [
      blank_node,
      resource(:bdo, "onYear"),
      @person.birth_year
    ]
    @graph << [
      blank_node,
      RDF.type,
      resource(:bdo, "PersonBirth")
    ]
  end

  def add_death
    blank_node = RDF::Node.new
    @graph << [
      @person_uri,
      resource(:bdo, "personEvent"),
      blank_node
    ]
    @graph << [
      blank_node,
      resource(:bdo, "onYear"),
      @person.death_year
    ]
    @graph << [
      blank_node,
      RDF.type,
      resource(:bdo, "PersonDeath")
    ]
  end

  def resource(prefix, name)
    RDF::URI(create_resource(prefix, name))
  end

  def language_code(language_type)
    return '' if language_type.nil?
    case language_type.language_type_key
    when 'russian' 
    end
  end
end
