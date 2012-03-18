class AddApiidToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :api_id, :integer

  end
end
