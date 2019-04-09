class ApplicationController < ActionController::Base
  def home
    render :html => 'use /resource/<p_id>'
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
