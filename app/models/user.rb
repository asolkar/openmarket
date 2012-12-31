class User < ActiveRecord::Base
  attr_accessible :created_at, :email, :fullname, :id, :password_digest, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
end
