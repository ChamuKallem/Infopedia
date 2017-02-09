require 'rails_helper'
require 'spec_helper'

RSpec.describe WikisController, type: :controller do

  # let(:my_user) {User.create!(email: "user@blocipedia.com", password: "helloworld")}
  # let(:my_wiki) {Wiki.create!(title: "Dogs", body: "Happy Beings", private: false, user_id: my_user.id)}
  # let(:my_user){create(:user)}
  # let(:my_wiki){create(:wiki)}

  describe "GET index" do
    before do
      @testuser = User.new(email: "user@blocipedia.com", password: "helloworld")
      @testuser.skip_confirmation!
      @testuser.save
      sign_in @testuser
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


  describe "GET new" do
    before do
      @testuser = User.new(email: "user@blocipedia.com", password: "helloworld")
      @testuser.skip_confirmation!
      @testuser.save
      sign_in @testuser
      @testwiki = Wiki.new(title: "Dogs", body: "Happy Beings", private: false, user: @testuser)
      @testwiki.save
    end
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
    before do
      @testuser = User.new(email: "user@blocipedia.com", password: "helloworld")
      @testuser.skip_confirmation!
      @testuser.save
      sign_in @testuser
      # @testwiki = Wiki.new(title: "Dogs", body: "Happy Beings", private: false, user: @testuser)
      # @testwiki.save
    end
    it "increases the number of Wiki by 1" do
       expect{post :create, wiki: {title: "Dogs", body: "Happy Beings", private: false, user: @testuser }}.to change(Wiki,:count).by(1)
      # expect{@testwiki}.to change(Wiki,:count).by(1)
    end
    it "assigns the new wiki to @wiki" do
      post :create, wiki: {title: "Dogs", body: "Happy Beings", private: false, user: @testuser }
      expect(assigns(:wiki)).to eq Wiki.last
    end
    it "redirects to the new wiki" do
      post :create, wiki: {title: "Dogs", body: "Happy Beings", private: false, user: @testuser}
      expect(response).to redirect_to Wiki.last
    end

  end
  describe "GET show" do
    before do
      @testuser = User.new(email: "user@blocipedia.com", password: "helloworld")
      @testuser.skip_confirmation!
      @testuser.save
      sign_in @testuser
      @testwiki = Wiki.new(title: "Dogs", body: "Happy Beings", private: false, user: @testuser)
      @testwiki.save
    end
     it "returns http success" do

       get :show, {id: @testwiki.id}
       expect(response).to have_http_status(:success)
     end
     it "renders the #show view" do
 # #17
       get :show, {id: @testwiki.id}
       expect(response).to render_template :show
     end

     it "assigns @testwiki to @wiki" do
       get :show, {id: @testwiki.id}
 # #18
       expect(assigns(:wiki)).to eq(@testwiki)
     end
   end
   describe "GET edit" do
     before do
       @testuser = User.new(email: "user@blocipedia.com", password: "helloworld")
       @testuser.skip_confirmation!
       @testuser.save
       sign_in @testuser
       @testwiki = Wiki.new(title: "Dogs", body: "Happy Beings", private: false, user: @testuser)
       @testwiki.save
     end
      it "returns http success" do
        get :edit, {id: @testwiki.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, {id: @testwiki.id}
        expect(response).to render_template :edit
      end

      it "assigns post to be updated to @post" do
        get :edit, {id: @testwiki.id}
        wiki_instance = assigns(:wiki)
        expect(wiki_instance.id).to eq @testwiki.id
        expect(wiki_instance.title).to eq @testwiki.title
        expect(wiki_instance.body).to eq @testwiki.body
        expect(wiki_instance.private).to eq @testwiki.private
      end
    end

    describe "PUT update" do
      before do
        @testuser = User.new(email: "user@blocipedia.com", password: "helloworld")
        @testuser.skip_confirmation!
        @testuser.save
        sign_in @testuser
        @testwiki = Wiki.new(title: "Dogs", body: "Happy Beings", private: false, user: @testuser)
        @testwiki.save
      end
     it "updates wiki with expected attributes" do
       new_title = "Dogs New"
       new_body = "Dogs can be dangerous"
       new_private = true

       put :update, id: @testwiki.id, wiki: {title: new_title, body: new_body, private: new_private}

       updated_wiki = assigns(:wiki)
       expect(updated_wiki.id).to eq @testwiki.id
       expect(updated_wiki.title).to eq new_title
       expect(updated_wiki.body).to eq new_body
       expect(updated_wiki.private).to eq new_private

     end

     it "redirects to the updated post" do
       new_title = "Dogs New"
       new_body = "Dogs can be dangerous"
       new_private = true

       put :update, id: @testwiki.id, wiki: {title: new_title, body: new_body, private: new_private}
       expect(response).to redirect_to @testwiki
     end
    end
    describe "DELETE destroy" do
      before do
        @testuser = User.new(email: "user@blocipedia.com", password: "helloworld")
        @testuser.skip_confirmation!
        @testuser.save
        sign_in @testuser
        @testwiki = Wiki.new(title: "Dogs", body: "Happy Beings", private: false, user: @testuser)
        @testwiki.save
      end
       it "deletes the wiki" do
         delete :destroy, {id: @testwiki.id}
   # #6
         count = Wiki.where({id: @testwiki.id}).size
         expect(count).to eq 0
       end

     it "redirects to posts index" do
       delete :destroy, {id: @testwiki.id}
 # #7
       expect(response).to redirect_to wikis_path
     end
   end

end
