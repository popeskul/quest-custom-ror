# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ModerationEventPolicy, type: :policy do
  subject { described_class.new(user, event) }

  context 'being a Visitor' do
    let(:user) { nil }
    let(:event) { create(:event) }

    it { is_expected.to forbid_actions(%i[index approve decline destroy new create edit update]) }
  end

  context 'being an authorized but not Admin' do
    let(:user) { create(:user) }
    let(:event) { create(:event) }

    it { is_expected.to forbid_actions(%i[index approve decline destroy new create edit update]) }
  end

  context 'being an authorized as Admin' do
    let(:user) { create(:user, admin: true) }
    let(:event) { create(:event, author: user) }

    it { is_expected.to permit_actions(%i[index approve decline]) }
    it { is_expected.to forbid_actions(%i[destroy new create edit update]) }
  end
end
