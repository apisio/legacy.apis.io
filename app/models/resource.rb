class Resource < ActiveRecord::Base
  belongs_to :api
  has_many :parameters
end
