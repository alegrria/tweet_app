class LoginController < ApplicationController
  def index
  	render :index
  end
  
  def oauth
  	@callback_url = "http://127.0.0.1:3000/callback"
	@consumer = OAuth::Consumer.new("b3shlPzonHvGNvGLcJmxIQRq9","uInEQ66GWBZMwoVBMQtZyeO6QlCBzfsL7kImf3G77j6hGhAoFJ", :site => "https://api.twitter.com/")
  	@request_token = @consumer.get_request_token(:oauth_callback => @callback_url)
	session[:token] = @request_token.token
	session[:token_secret] = @request_token.secret
	redirect_to @request_token.authorize_url(:oauth_callback => @callback_url)
  end
end