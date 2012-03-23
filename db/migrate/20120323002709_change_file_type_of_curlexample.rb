class ChangeFileTypeOfCurlexample < ActiveRecord::Migration
  def up
    change_column :resources, :curlexample, :text
  end

  def down
    change_column :resources, :curlexample, :string
  end
end
