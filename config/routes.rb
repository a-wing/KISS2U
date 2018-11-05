Rails.application.routes.draw do
  scope :api do
    match 'packages/cleanup', to: 'packages#cleanup', via: [:get, :post]
    resources :packages, only: [:index, :create]
    get 'packages/:id', to: 'packages#show', constraints: { id: /[\w, \-, \.]*/ }
  end
end
