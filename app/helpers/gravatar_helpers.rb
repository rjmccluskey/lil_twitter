require 'open-uri'

helpers do
  def gravatar_address(email,size=100)
    hash = Digest::MD5.hexdigest(email)
    default = "&d=" + URI::encode('http://www.crown-church.org.uk/images/member_photos/default_user.jpg')
    "http://www.gravatar.com/avatar/" + hash + "?s=#{size}" + default
  end
end
