class Photo < ActiveRecord::Base
  attr_accessible :caption, :image, :image_cache, :remove_image

  belongs_to :item

  mount_uploader :image, PhotoUploader

  validates_presence_of :image, :scope => :item_id
end
