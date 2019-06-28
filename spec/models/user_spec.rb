require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { build(:user) }
    let(:user2) { build(:invalid_user) }
    context 'complete information' do
      it 'is valid' do
        expect(user).to be_valid
      end
    end

    context 'first_name not present' do
      it 'is invalid' do
        expect(user2).to_not be_valid
      end
    end

    context 'duplicate username' do
      it 'is invalid' do
        user.save
        username = user.username
        duplicate_user = build(:user, username: username)

        expect(duplicate_user).to_not be_valid
      end
    end
  end
end
