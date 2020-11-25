Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'users#login'
  post 'signup', to: 'users#create'

  get 'auth/person/:id', to: 'authentication#person_check'
end
