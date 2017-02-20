class CollaboratorsController < ApplicationController
  skip_after_action :verify_authorized
  def create
      @wiki = Wiki.find(params[:wiki_id])
      id = "#{params[:collaborator]}"
      @user = User.where(id: id).first
      @collaborator = Collaborator.new(wiki: @wiki, user: @user)
      # collaborator = current_user.collaborator.build(wiki: wiki, user: user)
      puts "setting collaborator"
      puts @collaborator.id
      if @collaborator.save
        flash[:notice] = "Added a collaborator"
      else
        flash[:alert] = "can't add a collaborator"
      end
      redirect_to @wiki
  end
  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    id = "#{params[:collaborator]}"
    @user = User.where(id: id).first
    @collaborator = @wiki.collaborators.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "Added a collaborator"
    else
      flash[:alert] = "can't add a collaborator"
    end
    redirect_to @wiki
  end
end
