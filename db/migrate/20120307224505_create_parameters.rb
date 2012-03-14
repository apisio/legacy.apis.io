class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.integer :resource_id
      t.string :paramtype
      t.string :paramname
      t.string :paramvalue
      t.boolean :paramrequired
      t.string :paramdocurl

      t.timestamps
    end
  end
end
