class WikisController < ApplicationController

  def index
    # @wikis = Wiki.all
    @wikis = policy_scope(Wiki)
    # authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
 # #9

     @wiki = Wiki.new
     authorize @wiki
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]
     @wiki.private = params[:wiki][:private]
     @wiki.user_id = current_user.id

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
    authorize @wiki
  end
  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
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
     authorize @wiki
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end

  end
end
