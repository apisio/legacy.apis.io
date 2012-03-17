class AddAppidToParameters < ActiveRecord::Migration
  def change
    add_column :parameters, :app_id, :integer

  end
end
