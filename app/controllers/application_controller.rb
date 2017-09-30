class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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
  	return tweets
  end
end