class ApplicationController < ActionController::Base
				def home
								render :html => 'use /resource/<p_id>'
				end
end
