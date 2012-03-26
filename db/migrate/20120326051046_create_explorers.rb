class CreateExplorers < ActiveRecord::Migration
  def change
    create_table :explorers do |t|
      t.integer :user_id
      t.text :apirequest
      t.text :apiresponse

      t.timestamps
    end
  end
end
