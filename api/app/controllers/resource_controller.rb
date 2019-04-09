class ResourceController < ApplicationController
	def show
		id = params[:id]
    case id
    when /^P/
      @person = Person.find_by_person_id(id[1..-1]) or not_found
      @person_json = JSON.pretty_generate(@person.as_json)
      @person_rdf = SerializeResource.new(@person).serialize 
    else
      not_found
    end
	end	
end
