Rails.application.routes.draw do
  get 'sample/index'
  post 'sample/create'
  put 'sample/update'
  delete 'sample/delete'

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth"
    end
  end

  get 'start', to: 'logger#start'
  get 'finish', to: 'logger#finish'
  get 'index', to: 'logger#index'
end
