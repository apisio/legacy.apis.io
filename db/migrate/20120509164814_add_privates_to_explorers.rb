class AddPrivatesToExplorers < ActiveRecord::Migration
  def change
    add_column :explorers, :privateaccess, :boolean
    add_column :explorers, :provider, :string
  end
end
