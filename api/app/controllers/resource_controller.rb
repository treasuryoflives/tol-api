class ResourceController < ApplicationController
  
	def show

		id = params[:id]
    case id
    when /^TOLP/
      @person = Person
                .eager_load(name_variants: :encoding_type)
                .find_by_person_id(id[4..-1]) or not_found
    else
      not_found
    end

    respond_to do |format| 
      format.html do
        url_name = @person.url_default_name || @person.published_default_name
        url_name = url_name.gsub(' ', '-')
        redirect_to "https://treasuryoflives.org/biographies/view/#{url_name}/#{@person.person_id}"
      end
      format.jsonld do
        render_json
      end
      format.json do
        render_json
      end

      format.ttl do
        render plain: SerializeResource.new(@person, :ttl).serialize 
      end

      format.rdf do
        render_rdfxml
      end
      format.xml do
        render_rdfxml
      end
    end
	end	

  private

  def render_json
    render json: SerializeResource.new(@person, :jsonld).serialize       
  end

  def render_rdfxml
    render xml: SerializeResource.new(@person, :rdf).serialize
  end
end
