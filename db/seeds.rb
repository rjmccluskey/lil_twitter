10.times do
  user_args = {username: Faker::Internet.user_name, email: Faker::Internet.email}
  new_user = User.new(user_args)
  new_user.password = Faker::Internet.password
  new_user.save!
  10.times do
    Tweet.create!(content: Faker::Lorem.sentence, user_id: new_user.id)
  end
end

