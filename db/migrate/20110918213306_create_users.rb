class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.boolean :admin
      t.string :provider
      t.string :uid
      t.string :photo
      t.boolean :allowemail
      t.string :access_token
      t.string :access_secret
      t.string :first_name
      t.string :last_name
      t.string :website
      t.string :blog
      t.text   :about_me
      
      t.timestamps
    end
  end
end
