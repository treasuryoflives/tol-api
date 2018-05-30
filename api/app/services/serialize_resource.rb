# static methods for serializing Active Record resources
class SerializeResource
  def self.call(person)
    graph = RDF::Graph.new << [
      RDF::URI("http://purl.bdrc.io/resource/#{person.tbrc_rid}"),
      RDF.type,
      RDF::URI("http://purl.bdrc.io/ontology/core/Person")
    ]

    RDF::Turtle::Writer.buffer(
      prefixes: {
        bdr: "http://purl.bdrc.io/resource/",
        bdo: "http://purl.bdrc.io/ontology/core/"
      }
    ) do |writer|
      graph.each_statement do |statement|
        writer << statement
      end
    end
  end
end
