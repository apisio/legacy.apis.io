class Mashup < ActiveRecord::Base
  attr_accessible :api_id, :mashupdesc, :mashupimageurl, :mashupname, :mashupurl, :user_id

  belongs_to :user
  belongs_to :api

  validates :mashupname, :presence =>true
  validates :mashupurl, :presence =>true
  validates :mashupimageurl, :presence =>true
  validates :mashupdesc, :presence =>true
  validates_uniqueness_of :mashupname, :on => :create  

end
