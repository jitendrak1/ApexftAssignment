Rails.application.routes.draw do
  root 'apexftdata#index'
  resources :apexftdata
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
