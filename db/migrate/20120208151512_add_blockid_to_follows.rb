class AddBlockidToFollows < ActiveRecord::Migration
  def change
    add_column :follows, :block_id, :integer
  end
end
