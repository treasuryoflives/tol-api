require 'open-uri'

class BdrcSync
  BASE_URL = 'http://purl.bdrc.io/resource'
  
  def initialize

  end

  def run
    data = open("#{BASE_URL}/P264.ttl").read
    reader = RDF::Turtle::Reader.new(data) do |r|
      r.each_statement {|stmt| puts stmt.to_triple}
    end
  end
end

job = BdrcSync.new
job.run
