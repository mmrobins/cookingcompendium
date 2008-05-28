class MenusController < ApplicationController
  layout 'cookbook'
  # GET /menus
  # GET /menus.xml
  def index
    @menus = Menu.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @menus.to_xml }
    end
  end

  # GET /menus/1
  # GET /menus/1.xml
  def show
    @menu = Menu.find(params[:id])
    @available_recipes = Recipe.find(:all)

    respond_to do |format|
      format.html do
        @ingredients = @menu.ingredients; render :action => 'shopping_list' if params[:shopping_list]
      end
      format.xml  { render :xml => @menu.to_xml }
    end
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # GET /menus/1;edit
  def edit
    @menu = Menu.find(params[:id])
  end

  # POST /menus
  # POST /menus.xml
  def create
    @menu = Menu.new(params[:menu])

    respond_to do |format|
      if @menu.save
        flash[:notice] = 'Menu was successfully created.'
        format.html { redirect_to menu_url(@menu) }
        format.xml  { head :created, :location => menu_url(@menu) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @menu.errors.to_xml }
      end
    end
  end

  # PUT /menus/1
  # PUT /menus/1.xml
  def update
    @menu = Menu.find(params[:id])

    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        flash[:notice] = 'Menu was successfully updated.'
        format.html { redirect_to menu_url(@menu) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu.errors.to_xml }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.xml
  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to menus_url }
      format.xml  { head :ok }
    end
  end
end
