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
  	redirect_to "https://api.twitter.com/1.1/statuses/Dende_Nu_timeline.json"
  end
end