require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let(:lebron) { create(:user) }
  let(:kahwi) { create(:user) }

  context 'level 1 user editing own account' do
    subject { UserPolicy.new(lebron, lebron) }
    it { is_expected.to permit_action(:update) }
  end

  context "level 1 user editing another person's account" do
    subject { UserPolicy.new(lebron, kahwi) }
    it { is_expected.to_not permit_action(:update) }
  end

  context "level 3 user changing a user's level" do
    let(:admin) { create(:user, access_level: 3) }
    subject { UserPolicy.new(admin, lebron)}
    it { is_expected.to permit_mass_assignment_of([:access_level]) }
    it {
      is_expected.to(
        forbid_mass_assignment_of(
          %i[username email first_name last_name password password_confirmation]
        )
      )
    }
  end
end
