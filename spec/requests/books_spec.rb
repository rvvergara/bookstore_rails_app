require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET /v1/books' do
    let(:larry) { create(:user) }
    context 'authenticated user request' do
      it 'is an authorized request' do
        login_as(larry)
        larry_token = user_token
        get '/v1/users', headers: { "Authorization": "Bearer #{larry_token}" }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'unauthenticated user request' do
      let(:stalker) { create(:user) }

      it 'is an unauthorized request' do
        get '/v1/users' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    context 'paginated result' do
      before do
        12.times do
          create(:book)
          login_as(larry)
        end
      end

      context 'page 1 of results' do
        it 'sends a response containing first 10 books' do
          get '/v1/books', headers: {
            "Authorization": "Bearer #{user_token}"
          }

          expect(JSON.parse(response.body)['books'].count).to be(10)
        end
      end

      context 'page 2 or results' do
        it 'sends a response with last 2 books' do
          get '/v1/books?page=2', headers: {
            "Authorization": "Bearer #{user_token}"
          }

          expect(JSON.parse(response.body)['books'].count).to be(2)
        end
      end
    end
  end

  describe 'GET /v1/books/:id' do
    context 'authenticated user' do
      let(:ruby) { create(:book, title: 'Rails Tutorial') }
      let(:jim) { create(:user, username: "jim") }

      it 'is an authorized request and returns data' do
        create(:collection_item, user_id: jim.id, book_id: ruby.id)

        login_as(jim)
        jim_token = user_token

        get "/v1/books/#{ruby.id}", headers: { "Authorization": "Bearer #{jim_token}" }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['book']['included']).to be(true)
        expect(JSON.parse(response.body)['book']['item_id']).to_not be(nil)
      end
    end
  end

  describe 'POST /v1/books' do
    let(:admin) { create(:user, access_level: 2) }

    context 'admin user' do
      it 'creates a new book' do
        login_as(admin)
        admin_token = user_token

        expect do
          post '/v1/books', params: {
            book: attributes_for(:book)
          }, headers: { "Authorization": "Bearer #{admin_token}" }
        end.to change(Book, :count).by(1)
      end
    end
  end

  describe 'PUT /v1/books/:id' do
    let(:admin) { create(:user, access_level: 2) }
    let(:alladin) { create(:book, title: "Alladin") }

    context 'authorized book update' do
      it 'sends a JSON response with book data' do
        login_as(admin)
        subtitle = 'Return of Jaafar'

        put "/v1/books/#{alladin.id}", params: {
          book: attributes_for(:book, subtitle: subtitle)
        }, headers: { "Authorization": "Bearer #{user_token}" }
        alladin.reload
        expect(alladin.subtitle).to eq(subtitle)
      end
    end
  end
end
