class Shop < ActiveRecord::Base
  attr_accessible :created_at, :name, :description, :user_id, :items

  belongs_to :user
  has_many :items

  validates_presence_of :name, :on => :create
  validates_presence_of :description, :on => :create
  validates_uniqueness_of :name, :scope => :user_id
  validates_associated :user, :items
end
