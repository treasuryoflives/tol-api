class ResourceController < ApplicationController
	def show
		person_id = params[:id]
		@person = Person.find_by_tbrc_rid(person_id)
		@person_json = JSON.pretty_generate(@person.as_json)
    @person_rdf = SerializeResource.call(@person) 
	end	
end
