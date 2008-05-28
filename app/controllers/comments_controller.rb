class CommentsController < ApplicationController
  before_filter :find_recipe

  # GET /comments/new
  def new
    @comment = Comment.new
    respond_to do |format|
      format.js
    end
  end

  # GET /comments/1;edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new(params[:comment])
    @comment.user_id = @current_user.id

    respond_to do |format|
      if @recipe.comments << @comment
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to recipe_url(@recipe) }
        format.xml  { head :created, :location => comment_url(@comment) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors.to_xml }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
#  def update
#    @comment = Comment.find(params[:id])
#
#    respond_to do |format|
#      if @comment.update_attributes(params[:comment])
#        flash[:notice] = 'Comment was successfully updated.'
#        format.html { redirect_to comment_url(@comment) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @comment.errors.to_xml }
#      end
#    end
#  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
#  def destroy
#    @comment = Comment.find(params[:id])
#    @comment.destroy
#
#    respond_to do |format|
#      format.html { redirect_to comments_url }
#      format.xml  { head :ok }
#    end
#  end
end
