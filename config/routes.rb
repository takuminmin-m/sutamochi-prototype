Rails.application.routes.draw do
  get 'sample/index'
  post 'sample/create'
  put 'sample/update'
  delete 'sample/delete'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
