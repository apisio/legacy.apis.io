class AddTrusteeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :trustee, :boolean
  end
end
