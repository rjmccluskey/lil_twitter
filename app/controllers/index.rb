
get '/user/:id' do
  @user = User.find(params[:id])
  @tweets = @user.tweets.reverse
  erb :'user/profile'
end

get '/users/:id/edit' do
  erb :'user/edit'
end

post '/users/:id/edit' do
  @edited_user = User.update(params[:user])
  redirect "/users/#{@edited_user.id}"
end

get '/users/:id/followers' do
  @followers = User.find(params[:id]).followers
  erb :'user/followers'
end

get '/users/:id/following' do
  @following = User.find(params[:id]).following
  erb :'user/following'
end

get '/user/:id/timeline' do
  @user = User.find(params[:id])
  @tweets = []

  @user.following.each do |followee|
    @tweets << followee.tweets
  end

  @tweets.sort_by! {|tweet| tweet.created_at }.reverse

  erb :'user/profile'
end

get '/tweets/:id/edit' do
  @tweet = Tweet.find(params[:id])
  erb :'tweet/edit'
end

put '/tweets/:id/edit' do
  @tweet_id = Tweet.find(params[:id])
  @tweet = Tweet.find(params[:id]).update(content: params[:new_content])
  redirect ("users/#{@tweet_id.user_id}")
end









