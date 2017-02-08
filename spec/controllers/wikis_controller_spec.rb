require 'rails_helper'
require 'spec_helper'

RSpec.describe WikisController, type: :controller do

  # let(:my_user) {User.create!(email: "user@blocipedia.com", password: "helloworld")}
  #
  # let(:my_wiki) {Wiki.create!(title: "Dogs", body: "Happy Beings", private: false, user_id: my_user.id)}
  # let(:my_user){create(:user)}
  # let(:my_wiki){create(:wiki)}

  describe "GET index" do
    before do
      @testuser = User.new(email: "user@blocipedia.com", password: "helloworld")
      @testuser.skip_confirmation!
      @testuser.save
      @testwiki = Wiki.new(title: "Dogs", body: "Happy Beings", private: false, user: @testuser)
      @testwiki.save
    end
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [my_wiki] to @wikis" do
      get :index

      expect(assigns(:wikis)).to eq([@testwiki])
    end
  end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @wiki" do
      get :new
      expect(assigns(:wiki)).not_to be_nil
    end
  end
  describe "POST create" do
    it "increases the number of Wiki by 1" do
      expect{wiki :create, wiki: {title: "Dogs", body: "Happy Beings", private: false, user_id: my_user.id }}.to change(Wiki,:count).by(1)
    end
    it "assigns the new wiki to @wiki" do
      wiki :create, wiki: {title: "Dogs", body: "Happy Beings", private: false, user_id: my_user.id }
      expect(assigns(:wiki)).to eq Wiki.last
    end
    it "redirects to the new wiki" do
      wiki :create, wiki: {title: "Dogs", body: "Happy Beings", private: false, user_id: my_user.id }
      expect(response).to redirect_to Wiki.last
    end
  end
  #
  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
