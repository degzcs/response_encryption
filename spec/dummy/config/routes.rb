Rails.application.routes.draw do

  resources :organizations do
    member do
      get 'details', to: 'details'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
