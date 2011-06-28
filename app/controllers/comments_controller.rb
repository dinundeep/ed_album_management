class CommentsController < ApplicationController
layout :set_layout
  # GET /comments
  # GET /comments.json
#   layout 'employee_layout'
  def index
    @comments = Comment.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])
    @photo = Photo.find(params[:photo_id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
      @album = Album.find(params[:album_id])
      @photo = @album.photos
      @comment = @photo.comments.build()
      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @album = Album.find(params[:album_id])
    @photo = @album.photos
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.build(:comment_name => params[:comment_name])
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { render :partial => "photo_comment" }
      else
        format.html { render :text => "error" }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @album = Album.find(params[:album_id])
    @photo = @album.photos
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to album_photo_comment_path, notice: 'Comment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to album_photo_comments_path }
      format.json { head :ok }
    end
  end
end
