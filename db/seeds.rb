5.times do
  user = User.create(username: Faker::Internet.user_name, email: Faker::Internet.free_email, password: "boom")
  rand(1..10).times do
    user.tweets << Tweet.create(content: Faker::Company.catch_phrase)
  end
end
25.times do
  Following.create(user_id: rand(1..5), follower_id: rand(1..5))
end
