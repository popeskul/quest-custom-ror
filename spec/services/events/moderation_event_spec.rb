# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Services::ModerationEvent do
  let(:create_event) { create(:event) }

  subject { double('Events::Services::ModerationEvent') }

  describe '.new' do
    it 'init new object' do
      allow(subject).to receive('new').with(create_event)
    end
  end
end
