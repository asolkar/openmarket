class Item < ActiveRecord::Base
  attr_accessible :active, :created_at, :description, :name, :price,
                  :quantity, :shop, :shop_id, :user, :user_id,
                  :db_seeding

  has_many :photos

  belongs_to :shop
  belongs_to :user

  validates_uniqueness_of :name, :scope => :shop_id
  validates_associated :shop, :unless => :db_seeding
end
