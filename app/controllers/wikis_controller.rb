class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def show
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
       flash[:notice] = "Post was saved."
       redirect_to @wiki
     else
 # #12
       flash.now[:alert] = "There was an error saving the Wiki. Please try again."
       render :new
     end
  end


  def edit
  end

end
