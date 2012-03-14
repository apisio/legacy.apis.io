class Api < ActiveRecord::Base
  belongs_to :user
  has_many :statuses
  has_many :resources
end
