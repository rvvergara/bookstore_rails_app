require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "POST /books" do
    let(:admin) { create(:user, access_level: 2)}

    context "admin user" do
      it "creates a new book" do
        login_as(admin)
        admin_token = user_token

        expect {
          post "/v1/books", params: {
            book: attributes_for(:book, category: create(:category))
          }, headers: { "Authorization": "Bearer #{admin_token}"}
          }.to change(Book, :count).by(1)
      end
    end
  end
end
