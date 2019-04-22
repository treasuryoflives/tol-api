class ApplicationController < ActionController::Base
  def home
    render :html => 'use /resource/TOLP<p_id>'
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
