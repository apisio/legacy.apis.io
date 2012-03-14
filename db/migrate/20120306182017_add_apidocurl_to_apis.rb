class AddApidocurlToApis < ActiveRecord::Migration
  def change
    add_column :apis, :apidocurl, :string

  end
end
