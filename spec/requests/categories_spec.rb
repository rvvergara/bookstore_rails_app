require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let(:admin) { create(:user, access_level: 2, username: "admin")}
  let(:abner) { create(:user) }

  describe "POST /categories" do
    context "authorized user" do
      it "creates a new category" do
        login_as(admin)
        admin_token = user_token
        expect {
          post "/v1/categories", params: {
            category: attributes_for(:category)
          }, headers: { "Authorization": "Bearer #{admin_token}"}
        }.to change(Category, :count).by(1)
      end
    end

    context "unauthorized user" do
      it "doesn't create the category" do
        login_as(abner)
        abner_token = user_token
        expect {
          post "/v1/categories", params: {
            category: attributes_for(:category)
          }, headers: { "Authorization": "Bearer #{abner_token}"}
          }.to_not change(Category, :count)
      end
    end
  end
end
