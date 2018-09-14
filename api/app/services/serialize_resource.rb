# serializes an Active Record resources as RDF
class SerializeResource
  PREFIXES = {
    tol: "http://api.treasuryoflives.org/resource/",  
    bdr: "http://purl.bdrc.io/resource/",
    bdo: "http://purl.bdrc.io/ontology/core/",
    owl: "http://www.w3.org/2002/07/owl#",
    rdfs: "http://www.w3.org/2000/01/rdf-schema#"
  }

  def initialize(person)
    @person = person
    @graph = RDF::Graph.new
    @person_uri = resource(:tol, "P#{@person.person_id}")
  end

  def serialize
    add_triples

    RDF::Turtle::Writer.buffer(prefixes: PREFIXES) do |writer|
      @graph.each_statement do |statement|
        writer << statement
      end
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
    add_default_title
    add_wylie_name
    add_gender
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
      @person.default_name
    ]
    @graph << [
      blank_node,
      RDF.type,
      resource(:bdo, 'PersonPrimaryName'),
    ]
  end

  def add_wylie_name
    blank_node = RDF::Node.new
    @graph << [
      @person_uri,
      resource(:bdo, "personName"),
      blank_node
    ]
    @graph << [
      blank_node,
      RDF::RDFS.label,
      RDF::Literal.new(@person.wylie_name, :language => 'bo-x-ewts')
    ]
    @graph << [
      blank_node,
      RDF.type,
      resource(:bdo, 'PersonOtherName')
    ]
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

  def resource(prefix, name)
    RDF::URI(create_resource(prefix, name))
  end
end
