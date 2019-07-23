require 'rails_helper'

RSpec.describe 'CollectionItems', type: :request do
  let(:arnold) { create(:user, username: 'arnold') }
  let(:sly) { create(:user, username: 'sly') }
  let(:game_of_thrones) { create(:book, title: 'Game of Thrones') }
  let(:lotr) { create(:book, title: 'Lord of The Rings') }
  let(:item) do
    create(:collection_item, book_id: game_of_thrones.id, user_id: sly.id)
  end

  describe 'GET /v1/users/:user_username/collection' do
    context 'Arnold can see his own collection' do
      before do
        create(:collection_item, book_id: lotr.id, user_id: arnold.id)

        create(:collection_item, book_id: game_of_thrones.id, user_id: sly.id)
      end

      it 'shows only Lord of the Rings for Arnold' do
        login_as(arnold)
        arnold_token = user_token

        get "/v1/users/#{arnold.username}/collection", headers: {
          "Authorization": "Bearer #{arnold_token}"
        }
        expect(JSON.parse(response.body)['user']['collection'].first['title'])
          .to eq(lotr.title)
      end

      it 'only shows Game of Thrones for Sly' do
        login_as(sly)
        sly_token = user_token

        get "/v1/users/#{sly.username}/collection", headers: {
          "Authorization": "Bearer #{sly_token}"
        }

        expect(JSON.parse(response.body)['user']['collection'].first['title'])
          .to eq(game_of_thrones.title)
      end
    end
  end

  describe 'POST /v1/users/:user_username/collection' do
    context 'authenticated user' do
      it "adds book to the user's collection" do
        login_as(arnold)
        arnold_token = user_token

        expect do
          post "/v1/users/#{arnold.username}/collection", params: {
            collection_item: attributes_for(
              :collection_item, user_id: arnold.id, book_id: lotr.id
            )
          }, headers: {
            "Authorization": "Bearer: #{arnold_token}"
          }
        end.to change(CollectionItem, :count).by(1)
        expect(JSON.parse(response.body)['collection_item']['title'])
          .to eq(lotr.title)
      end
    end
  end

  describe 'PUT /v1/users/:user_username/collection/:id' do
    context 'Sly is logged on and updates page of Game of Thrones' do
      before do
        login_as(sly)
        sly_token = user_token

        put "/v1/users/#{sly.username}/collection/#{item.id}", params: {
          collection_item: { current_page: 20 }
        }, headers: { "Authorization": "Bearer #{sly_token}" }

        item.reload
      end

      it 'changes the current_page of Scorpions in the database' do
        expect(item.current_page).to be(20)
      end

      it 'returns an updated item.book_data as response' do
        expect(response).to have_http_status(:accepted)
        expect(JSON.parse(response.body)['collection_item'][:current_page])
          .to(eq(item.book.data_hash[:current_page]))
      end
    end
  end

  describe 'DELETE /v1/users/:user_username/collection/:id' do
    context 'sly deletes Game of Thronees from his collection' do
      it 'removes collection from the database' do
        login_as(sly)
        sly_token = user_token
        delete "/v1/users/#{sly.username}/collection/#{item.id}",
               headers: { "Authorization": "Bearer #{sly_token}" }
        expect(CollectionItem.all.include?(item)).to be(false)
      end
    end
  end
end
