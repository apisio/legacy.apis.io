class AddRefToExplorers < ActiveRecord::Migration
  def change
    add_column :explorers, :reference, :string
  end
end
