class Photo < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => '/images/admin.jpeg'
  belongs_to :album
  has_many :comments
  has_many :users, :through => :comments

  def is_owner?(user)
    album =  user.albums.find(:first,:conditions=>[" id = ? " ,self.album.id]) 
    album ? true : false 
  end
end
