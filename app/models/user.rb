class User < ActiveRecord::Base
  validates_uniqueness_of :username, :on => :create  
  has_many :apis
  has_many :statuses
  has_many :follows    
  has_many :explorers    
end
