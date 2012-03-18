class RemoveAppidFromParameters < ActiveRecord::Migration
  def up
    remove_column :parameters, :app_id
  end

  def down
    add_column :parameters, :app_id
  end
end
