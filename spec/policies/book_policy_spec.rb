require 'rails_helper'

RSpec.describe BookPolicy, type: :policy do
  let(:admin) { create(:user, access_level: 2) }
  let(:user) { create(:user, access_level: 1) }

  context 'admin book creation and update' do
    subject { BookPolicy.new(admin, nil) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
  end

  context 'unauthorized book creation and update' do
    subject { BookPolicy.new(user, nil) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
  end
end
