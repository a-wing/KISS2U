Rails.application.routes.draw do
  resources :packages, only: [:index, :create]
  get 'packages/:id', to: 'packages#show', constraints: { id: /[\w, \-, \.]*/ }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
