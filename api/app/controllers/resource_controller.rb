class ResourceController < ApplicationController
  
	def show

		id = params[:id]
    case id
    when /^P/
      @person = Person.find_by_person_id(id[1..-1]) or not_found
    else
      not_found
    end

    respond_to do |format| 
      format.html do
        url_name = @person.url_default_name.gsub(' ', '-')
        redirect_to "https://treasuryoflives.org/biographies/view/#{url_name}/#{@person.person_id}"
      end
      format.jsonld do
        render json: SerializeResource.new(@person, :jsonld).serialize       
      end
      format.turtle do
        render plain: SerializeResource.new(@person, :turtle).serialize 
      end
      format.rdfxml do
        render xml: SerializeResource.new(@person, :rdfxml).serialize
      end
    end
	end	

end
