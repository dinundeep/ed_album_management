class PhotosController < ApplicationController

  # GET /photos
  # GET /photos.json
  layout 'employee_layout'
  def index
    @album = Album.find(params[:album_id])
    #@photos = Album.photos
    @photos = @album.photos
    #@photos = Album.photos
    #@album = Album.find(params[:album_id])
    #@photo = @album.photos
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])
    @comments = @photo.comments
    @user = User.all
    #@photo = Photo.all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @album = current_user.albums.find(params[:album_id])
    #unless @album
     # flash[:notice] = "You can not add photos to this album" 
     # redirect_to my_albums_albums_path and return
    #end
    @photo = @album.photos.build()
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
    
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
    @album = @photo.album
    #@album = Album.find(params[:album_id])
    #@photo = @album.photos.build(params[:photo])
  end

  # POST /photos
  # POST /photos.json
  def create
    @album = Album.find(params[:album_id])
    @photo = @album.photos.build(params[:photo])
    respond_to do |format|
      if @photo.save
        format.html { redirect_to album_photo_path(@album,@photo), notice: 'Photo was successfully uploaded.' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    #@photo = Photo.find(params[:id])
    @album = Album.find(params[:album_id])
    @photo = @album.photos.build(params[:photo])
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    @album = current_user.albums.find(@photo.album.id)
    unless @album
      flash[:notice] = "You can not delete this photo" 
      redirect_to album_photos_path and return
    end
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to album_photos_url(album) }
      format.json { head :ok }
    end
  end

  def download
    @photo = Photo.find(params[:id])
    send_file @photo.image.path, :type => @photo.image.content_type, :disposition => 'attachment' 
  end

  def all_album_photos
    @album = Album.find(params[:album_id])
    @photos = @album.photos
    #render :template => 'photos/all_album_photos'
    render :template => 'photos/index'
  end
end
