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

  def add_triples
    add_type
    add_bdr_link
    add_default_name
    add_default_title
  end

  def add_type
    @graph << [
      RDF::URI(create_resource(:tol, "P#{@person.person_id}")),
      RDF.type,
      RDF::URI(create_resource(:bdo, 'Person'))
    ]
  end

  def add_bdr_link
    @graph << [
      RDF::URI(create_resource(:tol, "P#{@person.person_id}")),
      RDF::OWL.sameAs,
      RDF::URI(create_resource(:bdr, @person.tbrc_rid))
    ]
  end

  def add_default_name
    @graph << [
      RDF::URI(create_resource(:bdo, 'PersonPrimaryName')),
      RDF::RDFS.label,
      @person.default_name
    ]
  end

  def add_default_title
    @graph << [
      RDF::URI(create_resource(:bdo, 'PersonPrimaryTitle')),
      RDF::RDFS.label,
      @person.default_title
    ]
  end
end
