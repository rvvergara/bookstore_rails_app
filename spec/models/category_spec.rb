require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:martial_arts) { build(:category, name: "Martial Arts") }
  let(:duplicate) { build(:category, name: "Martial Arts") }
  let(:empty) { build(:category, name: nil)}

  describe "validation" do
    context "name present" do
      it "is valid" do
        expect(martial_arts).to be_valid
      end
    end

    context "name is absent" do
      it "is invalid" do
        expect(empty).to_not be_valid
      end
    end

    context "duplicate category name" do
      it "is invalid" do
        martial_arts.save
        duplicate.valid?
        expect(duplicate.errors['name']).to include('has already been taken')
      end
    end
  end
end
