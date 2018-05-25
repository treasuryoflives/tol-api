Rails.application.routes.draw do
  root 'application#home'

	get 'resource/:id', to: 'resource#show'
end
