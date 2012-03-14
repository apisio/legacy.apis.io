class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :api_id
      t.string :resourcename
      t.string :pathurl
      t.string :resourcemethod
      t.string :authentication
      t.string :curlexample
      t.string :docurl
      t.text :description

      t.timestamps
    end
  end
end
