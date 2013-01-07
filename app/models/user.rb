class User < ActiveRecord::Base
  attr_accessible :created_at, :username, :email, :fullname, :id,
                  :password_digest, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :shops
  has_many :items, :through => :shops

  def to_param
    username
  end
end
