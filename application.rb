require "bundler"

Bundler.setup(:default)
Bundler.require

enable :sessions
set :session_secret, "76a27efb4778af96fadaee9533eb17a0b54fe93861fe1d0b83361d1c6fd20d1d5010a56df30b6a99"

TWITTER_CONSUMER_KEY = "uDJYut5weyy3oiSg0A5A"
TWITTER_CONSUMER_SECRET = "hmK5C9G7Xl72rYlumVtKBJhWGCj5GL5C2Kaf7G9rQ"

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

use OmniAuth::Builder do
  provider :twitter, TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET
end

Twitter.configure do |config|
  config.consumer_key = TWITTER_CONSUMER_KEY
  config.consumer_secret = TWITTER_CONSUMER_SECRET
end

require File.expand_path('../controller/home', __FILE__)
