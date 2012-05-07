class AddPrivateaccessToApis < ActiveRecord::Migration
  def change
    add_column :apis, :privateaccess, :boolean
    add_column :apis, :provider, :string
  end
end
