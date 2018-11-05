Rails.application.routes.draw do
  scope :api do
    resources :packages, only: [:index, :create]
    get 'packages/:id', to: 'packages#show', constraints: { id: /[\w, \-, \.]*/ }
  end
end
