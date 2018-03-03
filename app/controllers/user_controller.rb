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
    return redirect to('/tweets') if logged_in?
    haml :'users/create_user'
  end

  post '/signup' do
    params.delete(:submit)
    return redirect to('/signup') if params.has_value?('')
    user = User.create(params)
    redirect to('/tweets')
  end

  get '/login' do
    return redirect to('/tweets') if logged_in?
    haml :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    return redirect to('/login') unless user && user.authenticate(params[:password])

    session[:user_id] = user.id
    flash[:message] = "Welcome, #{user.username}."
    redirect to('/tweets')
  end

  get '/logout' do
    session.clear
    redirect to('/login')
  end
end
