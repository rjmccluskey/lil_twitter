helpers  do

  def new_site_name
    '#' + (Faker::Company.bs).split.sample(rand(1..3)).map(&:capitalize).join(' ').gsub(/[aeiouy]*$/,'') + "itter"
  end

  def authorized?
    # p session[:user_id]
    !!session[:user_id]
  end

  def login(user)
    session[:user_id] = user.id
    session[:username] = user.username
  end

  def logout
    session.clear
    redirect_home
  end

  def session_username
    session[:username]
  end

  def session_user_id
    session[:user_id]
  end

  def redirect_home
    if authorized?
      puts "here"
      redirect "/user/#{session_user_id}"
    else
      redirect '/'
    end
  end
end
