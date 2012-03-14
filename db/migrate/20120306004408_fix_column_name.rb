class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :follows, :user_id, :api_id
  end

  def down
    rename_column :follows, :api_id, :user_id
  end
end
