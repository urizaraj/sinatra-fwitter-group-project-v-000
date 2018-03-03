class TweetController < ApplicationController
  get '/tweets' do
    haml :'tweets/tweets'
  end

end
