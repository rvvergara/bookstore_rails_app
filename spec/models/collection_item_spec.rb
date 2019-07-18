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
end
