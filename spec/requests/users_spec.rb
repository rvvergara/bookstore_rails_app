require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
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
end
