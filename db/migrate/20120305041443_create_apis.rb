class CreateApis < ActiveRecord::Migration
  def change
    create_table :apis do |t|
      t.integer :user_id
      t.string :name
      t.string :apiurl
      t.string :imageurl
      t.text :description
      t.string :category

      t.timestamps
    end
  end
end
