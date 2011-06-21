class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos ,:dependent => :destroy
  belongs_to :cover_photo, :class_name => "Photo" ,:foreign_key =>'cover_photo_id'

end
