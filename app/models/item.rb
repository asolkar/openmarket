class Item < ActiveRecord::Base
  attr_accessible :active, :created_at, :description, :name, :price, :quantity, :shop

  belongs_to :shop

  validates_uniqueness_of :name, :scope => :shop
  validates_associated :shop
end
