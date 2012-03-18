class Status < ActiveRecord::Base
  belongs_to :api
  belongs_to :user
end
