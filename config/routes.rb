Rails.application.routes.draw do
  root 'login#index'
  get 'oauth', controller: :login, action: :oauth
  get 'callback', controller: :accesstoken, action: :callback 

end
