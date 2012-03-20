class Api < ActiveRecord::Base
  belongs_to :user
  has_many :statuses
  has_many :resources
  
  validates :name, :presence =>true
  validates :apiurl, :presence =>true
  validates :imageurl, :presence =>true
  validates :description, :presence =>true
  validates :apidocurl, :presence =>true
  validates :category, :presence =>true
end
