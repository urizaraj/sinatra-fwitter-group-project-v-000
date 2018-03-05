class TweetController < ApplicationController
  get '/tweets' do
    redirect to '/login' unless logged_in?

    @tweets = Tweet.all
    haml :'tweets/tweets'
  end

  get '/tweets/new' do
    haml :'tweets/create_tweet'
  end

  post '/tweets/new' do
    redirect to('/tweets/new') if params.has_value?('')

    tweet = Tweet.new
    tweet.content = params[:content]
    tweet.user_id = current_user.id
    tweet.save

    redirect to '/tweets'
  end
end
