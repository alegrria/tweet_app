class AccesstokenController < ApplicationController  
  hash = { oauth_token: session[:token], oauth_token_secret: session[:token_secret]}
  @request_token  = OAuth::RequestToken.from_hash(@consumer, hash)
  @access_token = @request_token.get_access_token
end
