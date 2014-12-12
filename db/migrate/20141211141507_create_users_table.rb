class CreateUsersTable < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  	  t.string 	 :username
  	  t.string   :encrypted_password
  	  t.string	 :full_name
  	  t.text	 :about_me
  	  t.text	 :picture_url

  	  t.timestamps
  	end
  end
end
