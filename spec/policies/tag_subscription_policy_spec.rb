# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagSubscriptionPolicy, type: :policy do
  subject { described_class.new(user) }

  context 'being a visitor' do
    let(:user) { nil }

    it { is_expected.to permit_actions(%i[new create]) }
    it { is_expected.to forbid_actions(%i[index destroy show edit update]) }
  end
end
