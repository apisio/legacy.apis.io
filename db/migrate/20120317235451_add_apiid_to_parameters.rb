class AddApiidToParameters < ActiveRecord::Migration
  def change
    add_column :parameters, :api_id, :integer

  end
end
