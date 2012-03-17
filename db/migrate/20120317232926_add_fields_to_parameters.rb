class AddFieldsToParameters < ActiveRecord::Migration
  def change
    add_column :parameters, :paramstyle, :string

    add_column :parameters, :paramdefault, :string

    add_column :parameters, :description, :text

    add_column :parameters, :payload, :text

  end
end
