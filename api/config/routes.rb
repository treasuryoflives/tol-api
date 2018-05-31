Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'application#home'

	get 'resource/:id', to: 'resource#show'
end
