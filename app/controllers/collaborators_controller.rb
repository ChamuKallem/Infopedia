class CollaboratorsController < ApplicationController
  skip_after_action :verify_authorized
  def create
      @wiki = Wiki.find(params[:wiki_id])
      id = "#{params[:collaborator]}"
    
      @user = User.where(id: id).first


      @collaborator = Collaborator.new
      #Wiki.users.new
      # collaborator = current_user.collaborator.build(wiki: wiki, user: user)
      @collaborator.wiki_id = @wiki.id
      @collaborator.user_id = @user.id
      @collaborator.email = @user.email

      if @collaborator.save
        flash[:notice] = "Added a collaborator"
      else
        flash[:alert] = "can't add a collaborator"
      end
      redirect_to @wiki
  end
  def build
    #this builds a collaborator list on a wiki.
    @wiki = Wiki.find(params[:wiki_id])

  end
  def destroy

    @wiki = Wiki.find(params[:wiki_id])
    id = "#{params[:id]}"
    @user = User.where(id: id).first
    @collaborator = @wiki.collaborators.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "Removed a collaborator"
    else
      flash[:alert] = "can't add a collaborator"
    end
    redirect_to @wiki

  end
end
