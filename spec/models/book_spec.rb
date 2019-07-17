require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    let(:harry) { build(:book) }
    context "complete book details" do
      it "is valid" do
        expect(harry).to be_valid
      end
    end

    context "title not present" do
      it "is invalid" do
        harry.title = nil
        harry.valid?
        expect(harry.errors["title"]).to include("can't be blank")
      end
    end
  end

  describe "#search_by_term scope" do
    before do
      10.times do
        create(:book)
      end

      create(:book, title:"Cook book", subtitle: "The art and science of cooking")
    end

    context "searching for a book about cooking" do
      it "returns 1 result" do
        expect(Book.search_by_term("cook").size).to eq(1)
        expect(Book.search_by_term("cooking").size).to eq(1)
      end
    end
  end
end
