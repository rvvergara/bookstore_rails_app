require 'rails_helper'

RSpec.describe CategoryPolicy, type: :policy do
  let(:admin) { create(:user, access_level: 2) }
  let(:user) { create(:user, access_level: 1) }

  context "unauthorized category creation" do
    subject { CategoryPolicy.new( user, nil )}

    it { is_expected.to forbid_action(:create) }
  end

  context "admin creates a category" do
    subject { CategoryPolicy.new( admin, nil) }

    it { is_expected.to permit_action(:create)}
  end
end
