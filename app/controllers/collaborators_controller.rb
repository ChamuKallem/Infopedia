class CollaboratorsController < ApplicationController
  skip_after_action :verify_authorized
  def create
      @wiki = Wiki.find(params[:wiki_id])
      id = "#{params[:collaborator]}"
      @user = User.where(id: id).first
      puts @user.id
      puts @user.email

      puts "Wiki u are looking for"
      puts @wiki.title

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
end
