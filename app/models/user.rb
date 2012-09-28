class User < ActiveRecord::Base
  attr_accessible :created_at, :email, :fullname, :id, :secret, :token, :username
end
