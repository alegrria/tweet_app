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

  def prepare_access_token(oauth_token, oauth_verifier)
      #consumer = OAuth::Consumer.new("APIKey", "APISecret", { :site => "https://api.twitter.com", :scheme => :header })
      @consumer = OAuth::Consumer.new("b3shlPzonHvGNvGLcJmxIQRq9","uInEQ66GWBZMwoVBMQtZyeO6QlCBzfsL7kImf3G77j6hGhAoFJ", { :site => "https://api.twitter.com", :scheme => :header })

      # now create the access token object from passed values
      token_hash = { :oauth_token => oauth_token, :oauth_verifier => oauth_verifier }
      access_token = OAuth::AccessToken.from_hash(@consumer, token_hash )

      return access_token
  end

  def callback
  	@request_token = session[:request_token]
  	prepare_access_token(params[:oauth_token],params[:oauth_verifier])
  	@consumer = OAuth::Consumer.new(params[:oauth_token],params[:oauth_verifier], :site => "https://api.twitter.com")
    @access_token = prepare_access_token(params[:oauth_token],params[:oauth_token_secret])
  	redirect_to "https://twitter.com/following"
  end
end