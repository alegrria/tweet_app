class AccesstokenController < ApplicationController 

  def prepare_access_token(oauth_token, oauth_verifier)
    @consumer = OAuth::Consumer.new("b3shlPzonHvGNvGLcJmxIQRq9","uInEQ66GWBZMwoVBMQtZyeO6QlCBzfsL7kImf3G77j6hGhAoFJ", { :site => "https://api.twitter.com", :scheme => :header })
    token_hash = { :oauth_token => oauth_token, :oauth_verifier => oauth_verifier }
    access_token = OAuth::AccessToken.from_hash(@consumer, token_hash )
    return access_token
  end

  def callback
  	@request_token = session[:request_token]
  	prepare_access_token(params[:oauth_token],params[:oauth_verifier])
  	@consumer = OAuth::Consumer.new(params[:oauth_token],params[:oauth_verifier], :site => "https://api.twitter.com")
    @access_token = prepare_access_token(params[:oauth_token],params[:oauth_verifier])
    redirect_to tweets
  end

  def client
	client = Twitter::Streaming::Client.new do |config|
  	  config.consumer_key        = "b3shlPzonHvGNvGLcJmxIQRq9"
      config.consumer_secret     = "uInEQ66GWBZMwoVBMQtZyeO6QlCBzfsL7kImf3G77j6hGhAoFJ"
  	  config.access_token        = @access_token[0]
  	  config.access_token_secret = @access_token[1]
    end
  end

  def tweets
  	tweets = client.user(Twitter::Streaming::FriendList)
  	return @tweets
  end
end