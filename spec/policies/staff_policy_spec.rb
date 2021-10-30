# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::StaffPolicy, type: :policy do
  subject { described_class.new(admin, created_staff) }

  context 'being a Visitor' do
    let(:admin) { nil }
    let(:created_staff) { create(:staff) }

    it { is_expected.to forbid_actions(%i[index show destroy new create edit update]) }
  end

  context 'being an authorized but not Admin' do
    let(:admin) { create(:user) }
    let(:created_staff) { create(:staff) }

    it { is_expected.to forbid_actions(%i[index show destroy new create edit update]) }
  end

  context 'being an authorized as Admin' do
    let(:admin) { create(:staff) }
    let(:created_staff) { create(:staff) }

    it { is_expected.to forbid_actions(%i[show]) }
    it { is_expected.to permit_actions(%i[index destroy new create edit update]) }
  end
end
