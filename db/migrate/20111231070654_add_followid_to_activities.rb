class AddFollowidToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :follow_id, :integer
  end
end
