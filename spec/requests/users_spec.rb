require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /v1/users/:username" do
    before do
      @ana = create(:user)
      @dan = create(:user, username: "dan")

      login_as(@ana)

      @ana_token = JSON.parse(response.body)["user"]["token"]
    end

    context "authenticated user viewing another user's page" do
      it "returns a status of ok" do
        get "/v1/users/#{@dan.username}", headers: {"Authorization": "Bearer #{@ana_token}"}
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)["user"]["username"]).to eq(@dan.username)
      end
    end

    context "unauthenticated user" do
      it "returns unauthorized status" do
        get "/v1/users/#{@dan.username}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST /v1/users" do
    # Complete params
    context 'correct user data' do
      it 'creates a user' do
        user_attributes = attributes_for(:user)

        expect {
          post '/v1/users', params: {user: user_attributes}
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        
        expect(JSON.parse(response.body)['user']['token']).to_not be(nil)
      end
    end
    # Incomplete params
    context 'first_name is missing' do
      it 'creates a user' do
        invalid_attributes = attributes_for(:invalid_user)

        expect {
          post '/v1/users', params: {user: invalid_attributes}
        }.to_not change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    # Duplicate username
    context 'saving a user with a duplicate username' do
      it 'does not save user' do
        michael = create(:user, username: 'mike')
      
        expect {
          post '/v1/users', params: { user: attributes_for(:user, username: 'mike')}
        }.to_not change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /v1/users" do
    before do
      @marcus = create(:user, username: "marcus")
      @first_name = @marcus.first_name

      login_as(@marcus)
      
      @marcus_token = user_token
    end
    # User is logged in and changing his/her own account
    context "correct authenticated user edits first_name" do
      it "allows change" do
        put "/v1/users/#{@marcus.username}", params: {
          user: { first_name: "Alfredo"}
        }, headers: { "Authorization": "Bearer #{@marcus_token}"}
        expect(response).to have_http_status(:accepted)
        @marcus.reload
        expect(@marcus.first_name).to eq("Alfredo")
      end
    end
    # User is not logged in
    context "user not authenticated" do
      it "returns an unauthorized http response" do
        another_token = JsonWebToken.encode({id: "another_id"})
        put "/v1/users/#{@marcus.username}", params: {
          user: { first_name: "Alfredo"}
        }, headers: {"Authorization": "Bearer #{another_token}"}
        expect(response).to have_http_status(:unauthorized)
        @marcus.reload
        expect(@marcus.first_name).to eq(@first_name)
      end
    end
    # User is logged in but changing another user's account
    context "user authenticated but changing another account" do
     it "returns an unauthorized http response" do
      george = create(:user)

      login_as(george)

      george_token = user_token

      put "/v1/users/#{@marcus.username}", params: { 
        user: {
          first_name: "Rowan"
        }
      }, headers: { "Authorization": "Bearer #{george_token}"}

      expect(response).to have_http_status(:unauthorized)

      @marcus.reload
      expect(@marcus.first_name).to eq(@first_name)
     end
    end
  end
end
