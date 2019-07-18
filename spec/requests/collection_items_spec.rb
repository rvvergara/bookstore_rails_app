require 'rails_helper'

RSpec.describe "CollectionItems", type: :request do
  describe "GET /v1/users/:user_username/collection" do
    context "Arnold can see his own collection" do
      let(:arnold) { create(:user, username: "arnold") }
      let(:sly) { create(:user, username: "sly") }
      let(:game_of_thrones) { create(:book, title: "Game of Thrones") }
      let(:lotr) { create(:book, title: "Lord of The Rings")}
      
      before do
        create(:collection_item, book_id: lotr.id, user_id: arnold.id)
        
        create(:collection_item, book_id: game_of_thrones.id, user_id: sly.id)
      end

      it "shows only Lord of the Rings for Arnold" do
        login_as(arnold)
        arnold_token = user_token

        get "/v1/users/#{arnold.username}/collection", headers: { "Authorization": "Bearer #{arnold_token}"}
        expect(JSON.parse(response.body)["user"]["collection"].first["title"]).to eq(lotr.title)
      end

      it "only shows Game of Thrones for Sly" do
        login_as(sly)
        sly_token = user_token

        get "/v1/users/#{sly.username}/collection", headers: { "Authorization": "Bearer #{sly_token}"}

        expect(JSON.parse(response.body)["user"]["collection"].first["title"]).to eq(game_of_thrones.title)        
      end
    end
  end

  describe "POST /v1/users/:user_username/collection" do
    let(:mowgli) { create(:user, username: "mowgli") }
    let(:jungle_book) { create(:book, title: "The Jungle Book") }

    context "authenticated user" do
      it "adds book to the user's collection" do
        login_as(mowgli)
        mowgli_token = user_token

        expect {
          post "/v1/users/#{mowgli.username}/collection", params: {
            collection_item: attributes_for(:collection_item, user_id: mowgli.id, book_id: jungle_book.id)
          },
          headers: {
            "Authorization": "Bearer: #{mowgli_token}"
          }
        }.to change(CollectionItem, :count).by(1)
         expect(JSON.parse(response.body)["collection_item"]["title"]).to eq(jungle_book.title)
      end
    end
  end
end
