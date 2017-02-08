class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def show
  end

  def new
    @wiki = current_user.wikis.build
  end

  def edit
  end

end
