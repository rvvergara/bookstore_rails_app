require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'POST /sessions' do
    let(:john) { create(:user) }
    # Correct user credentials
    context 'correct email and password' do
      it 'results in a successful login' do
        session_params = {
          email_or_username: john.email, password: john.password
        }
        post '/v1/sessions', params: session_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['user']['token']).to_not be(nil)
      end
    end
    # Incorrect login credentials
    context 'incorrect password' do
      it 'results in an error' do
        session_params = { email_or_username: john.email, password: 'wrong' }

        post '/v1/sessions', params: session_params

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['message'])
          .to match('Invalid credentials')
      end
    end
  end
end
