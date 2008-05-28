class PhotosController < ApplicationController
  before_filter :find_recipe

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = @recipe.photos.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @photo.to_xml }
    end
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # POST /photos
  # POST /photos.xml
  def create
    @photo = Photo.new(params[:photo])
    respond_to do |format|
      if @recipe.photos << @photo
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to recipe_url(@recipe) }
        format.xml  { head :created, :location => photo_url(@photo) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors.to_xml }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = @recipe.photos.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to recipe_url(@recipe) }
      format.xml  { head :ok }
    end
  end
end
