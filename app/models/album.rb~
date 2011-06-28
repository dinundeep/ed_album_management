class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos ,:dependent => :destroy
  belongs_to :cover_photo, :class_name => "Photo" ,:foreign_key =>'cover_photo_id'
  accepts_nested_attributes_for  :photos,  :allow_destroy  => true
  def is_owner?(user)
    album =  user.albums.find(:first,:conditions=>[" id = ? " ,self.album.id]) 
    album ? true : false 
  end
end
