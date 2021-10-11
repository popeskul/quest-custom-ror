# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  subject { described_class.new(user, event) }

  context 'being a visitor' do
    let(:user) { nil }
    let(:event) { create(:event) }

    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_actions(%i[destroy]) }
  end

  context 'being an authorized but not author of resource' do
    let(:user) { create(:user) }
    let(:event) { create(:event) }

    it { is_expected.to permit_new_and_create_actions }

    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_actions(%i[destroy]) }
  end

  context 'being an author of resource' do
    let(:user) { create(:user) }
    let(:event) { create(:event, author: user) }

    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_actions(%i[destroy]) }
  end
end
