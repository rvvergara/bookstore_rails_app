require 'rails_helper'

RSpec.describe CollectionItem, type: :model do
  let(:collection_item) { build(:collection_item) }
  describe "validations" do
    context "complete details" do
      it "is valid" do
        expect(collection_item).to be_valid
      end
    end

    context "no current page" do
      it "is invalid" do
        collection_item.current_page = nil
        collection_item.valid?
        expect(collection_item.errors["current_page"]).to include("can't be blank")
      end
    end

    context "user wants to add same book to collection" do
      it "is raises an error" do
        james = create(:user)
        book = create(:book)
        item = create(:collection_item, book_id: book.id, user_id: james.id)
        duplicate = build(:collection_item, book_id: book.id, user_id: james.id)

        duplicate.valid?
        expect(duplicate.errors.full_messages.first).to include("Book can only be added once")
      end
    end

  end

  describe "associations" do
    context "user and book are present" do
      it "is valid" do
        expect(collection_item).to be_valid
      end
    end

    context "user isn't included" do
      it "is invalid" do
        collection_item.user = nil
        collection_item.valid?
        expect(collection_item.errors["user"]).to include("must exist")
      end
    end
  end

  describe '#data instance method' do
    let(:book) { create(:book) }
    let(:item) { create(:collection_item, book_id: book.id)}

    it 'returns book data hash w/ item infos' do
      expect(item.data[:current_page]).to eq(0)
      expect(item.data[:title]).to eq(book.title)
      expect(item.data[:item_id]).to eq(item.id)
    end
  end
end
