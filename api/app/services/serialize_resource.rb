class SerializeResource
  def self.call(person)
    graph = RDF::Graph.new << [:hello, RDF::RDFS.label, "Hello, world!"]
    graph.to_ttl
  end
end
