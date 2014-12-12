class User < ActiveRecord::Base
  has_many :tweets
  has_many :followers
  validates :username, presence: true
  validates :encrypted_password, presence: true
  validates :username, uniqueness: true

  def password
    @password ||= BCrypt::Password.new(encrypted_password)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.encrypted_password = @password
  end

  def authenticate(password)
    self.password == password
  end

end
