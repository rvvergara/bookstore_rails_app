require 'rails_helper'

RSpec.describe CollectionItemPolicy, type: :policy do
  let(:joey) { create(:user, username: "joey") }
  let(:mickey) { create(:user, username: "mickey") }
  let(:rich_dad) { create(:book, title: "Rich Dad Poor Dad")}
  let(:joey_rd_copy) { create(:collection_item, user_id: joey.id, book_id: rich_dad.id) }

  context "joey updates his read page of Rich Dad" do
    subject { CollectionItemPolicy.new(joey, joey_rd_copy) }
    it { is_expected.to permit_action(:update) }
  end

  context "mickey attempts to update joey's copy of RichDad" do
    subject { CollectionItemPolicy.new(mickey, joey_rd_copy)}
    it { is_expected.to forbid_action(:update) }
  end

end
