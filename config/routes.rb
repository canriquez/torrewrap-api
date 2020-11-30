Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'users#login'
  post 'signup', to: 'users#create'
  post 'asset_upload', to: 'assets#asset_upload'
  post 'asset_save', to: 'assets#asset_save'
  post 'asset_delete', to: 'assets#asset_delete'

  get 'auth/person/:id', to: 'authentication#person_check'
  get 'auth/wrapuser/:id', to: 'authentication#valid_wrap_user_check'
  get 'refresh', to: 'assets#refresh'
end
