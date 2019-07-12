require 'rails_helper'

RSpec.describe CategoryPolicy, type: :policy do
  let(:admin) { create(:user, access_level: 2) }
  let(:user) { create(:user, access_level: 1) }
  let(:history) { create(:category) }

  context "unauthorized category creation" do
    subject { CategoryPolicy.new( user, history )}

    it { is_expected.to forbid_action(:create) }
  end

  context "admin creates a category" do
    subject { CategoryPolicy.new( admin, history) }

    it { is_expected.to permit_action(:create)}
  end
end
