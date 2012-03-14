class User < ActiveRecord::Base
  # has_secure_password
  validates_uniqueness_of :username, :on => :create  
  # validates :email, :presence =>true,
  #                     :uniqueness=>true, :on => :create 
  # validates :password, :presence =>true,
  #                     :length => { :minimum => 5, :maximum => 40 },
  #                     :confirmation =>true, :on => :create 
  has_many :activities
  has_many :apis
  has_many :follows
  
  
  before_create { generate_token(:auth_token) }
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
end
