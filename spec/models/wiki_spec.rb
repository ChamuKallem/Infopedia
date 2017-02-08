require 'rails_helper'
require 'spec_helper'



RSpec.describe Wiki, type: :model do
  let(:user) {User.create!(email: "user@blocipedia.com", password: "helloworld")}

  let(:wiki) {Wiki.create!(title: "Dogs", body: "Happy Beings", private: false, user_id: user.id)}

  describe "attributes" do
    it "has title and body attributes" do
      expect(wiki).to have_attributes(title: "Dogs", body: "Happy Beings", private: false, user_id: user.id)
    end
  end

end
