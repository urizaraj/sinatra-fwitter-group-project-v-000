class UserController < ApplicationController
  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end

  get '/signup' do
    redirect '/tweets' if logged_in?
    haml :'users/create_user'
  end

  post '/signup' do
    redirect '/signup' if params.has_value?('')

    user = User.create(params[:user])

    redirect '/tweets'
  end

  get '/login' do
    redirect '/tweets' if logged_in?
    haml :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    redirect '/login' unless user && user.authenticate(params[:password])

    session[:user_id] = user.id
    flash[:message] = "Welcome, #{user.username}."
    redirect '/tweets'
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end
end