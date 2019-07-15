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
end
