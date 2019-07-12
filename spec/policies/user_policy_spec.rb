require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let(:current_user) { create(:user) }
  let(:another_user) { create(:user)}
  subject { UserPolicy.new(user, user) }
  
  context 'own account' do
    let(:user ) { current_user}
    it { is_expected.to permit_action(:update)}
  end

  context "other's account" do
    let(:user) { another_user}
    
  end
end
