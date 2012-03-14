class AddRegisteridToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :register_id, :integer
  end
end
