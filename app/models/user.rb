class User < ActiveRecord::Base
  attr_accessible :created_at, :name, :email, :fullname, :id, :password_digest, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :shops
  has_many :items, :through => :shops

  def to_param
    name
  end
end
