get '/' do
  erb :index
end

get '/session-viewer' do
  session.inspect
end

post '/login' do
  user = User.find_by(username: params[:username])
  if user != nil
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/home/#{user.username}"
    else
      erb :index
    end
  else
  	erb :index
  end
end

post '/sign-up' do
  if params[:password] == params[:password1] && User.find_by(username: params[:username]).nil?
    User.create(username: params[:username], encrypted_password: params[:password])
    user = User.find_by(username: params[:username])
    session[:user_id] = user.id
    user.password = params[:password]
    user.save
    redirect "/home/#{user.username}"
  else
    redirect '/'
  end  
end

get '/logout' do
  session.delete(:user_id)
  redirect '/'
end

post '/tweet' do
  user = User.find_by(id: session[:user_id])
  Tweet.create(content: params[:content], user_id: session[:user_id])
  redirect "/home/#{user.username}"
end


get '/home/:username' do
  @user = User.find_by(id: session[:user_id])
  @user_home = User.find_by(id: session[:user_id]).username
  @tweets = Tweet.where(user_id: session[:user_id])
  @following = Follower.where(follower_id: session[:user_id])
  redirect '/' unless session[:user_id]
  erb :'/home/home'
end

post '/follow' do
  @visiting = User.find_by(id: session[:visiting_id])
  session[:visiting_id] = @visiting.id
  Follower.create(follower_id: session[:user_id], followed_id: session[:visiting_id])
  redirect "/#{@visiting.username}"
end

get '/:username' do
  @user = User.find_by(id: session[:user_id]).username
  @user_home = User.find_by(id: session[:user_id]).username
  @visiting = User.find_by(username: params[:username])
  session[:visiting_id] = @visiting.id
  @tweets = Tweet.where(user_id: session[:visiting_id])
  @following = Follower.where(follower_id: session[:visiting_id])
  erb :'/home/visiting'
end




