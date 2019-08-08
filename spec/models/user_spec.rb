require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:james) { build(:user) }
    let(:mike) { build(:invalid_user) }
    context 'complete information' do
      it 'is valid' do
        expect(james).to be_valid
      end
    end

    context 'first_name not present' do
      it 'is invalid' do
        mike.valid?
        expect(mike.errors[:first_name]).to include("can't be blank")
      end
    end

    context 'duplicate username' do
      it 'is invalid' do
        james.save
        username = james.username
        james_again = build(:user, username: username)
        james_again.valid?
        expect(james_again.errors[:username])
          .to include('has already been taken')
      end
    end
  end

  describe '#username_downcase! method' do
    it 'downcases a username before saving a user' do
      arthur = build(:user, username: 'Arthur')
      arthur.save
      expect(arthur.username).to eq('arthur')
    end
  end

  describe '#collection method' do
    let(:john) { create(:user) }
    before do
      2.times do
        book = create(:book)
        create(:collection_item, book_id: book.id, user_id: john.id)
      end
    end

    it 'returns an array of books w/ current_pages' do
      expect(john.collection.size).to be(2)
    end
  end
end
