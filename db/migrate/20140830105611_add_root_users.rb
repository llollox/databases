class AddRootUsers < ActiveRecord::Migration
  def up
    User.create!(:username => 'llollox', :email => 'lore91tanz@gmail.com', :password => 'llollox1', :password_confirmation => 'llollox1')
    User.create!(:username => 'francesco', :email => 'checobeppe@hotmail.it', :password => 'maturi', :password_confirmation => 'maturi')
  end

  def down
    User.find_by_username('llollox').destroy
    User.find_by_username('francesco').destroy
  end
end
