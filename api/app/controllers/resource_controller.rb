class ResourceController < ApplicationController
	def show
		person_id = params[:id]
		person = Person.find_by_tbrc_rid(person_id)
		render :json => JSON.pretty_generate(person.as_json)
	end	
end
