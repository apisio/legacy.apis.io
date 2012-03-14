class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :status_id
      t.integer :contact_id

      t.timestamps
    end
  end
end
