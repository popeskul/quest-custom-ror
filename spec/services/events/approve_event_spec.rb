# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Services::ApproveEvent do
  let(:existing_event) { build(:event) }

  let(:approve_event) { Events::Services::ApproveEvent.new(existing_event) }

  describe '#call' do
    it 'user approve' do
      expect { approve_event.call }.to change { existing_event.aasm_state }.to 'approved'
    end

    it 'user can not approve twice' do
      approve_event.call
      expect(approve_event.call).to eq false
    end
  end
end
