class CreateMashups < ActiveRecord::Migration
  def change
    create_table :mashups do |t|
      t.integer :user_id
      t.integer :api_id
      t.string :mashupname
      t.string :mashupurl
      t.string :mashupimageurl
      t.text :mashupdesc

      t.timestamps
    end
  end
end
