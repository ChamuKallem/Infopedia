class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
 # #9
     @wiki = Wiki.new
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]
     @wiki.private = params[:wiki][:private]
     @wiki.user = current_user

 # #10
     if @wiki.save
 # #11
       flash[:notice] = "Wiki has been saved."
       redirect_to @wiki
     else
 # #12
       flash.now[:alert] = "There was an error saving the Wiki. Please try again."
       render :new
     end
  end


  def edit
    @wiki = Wiki.find(params[:id])
  end
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    if @wiki.save
      flash[:notice] = "Post was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the Wiki. Please try again."
      render :edit
    end
  end
  def destroy
     @wiki = Wiki.find(params[:id])
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end

  end
end
