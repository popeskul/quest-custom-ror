# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Event do
  let!(:existing_user) { create(:user) }
  let(:existing_event) { create(:event, author: existing_user) }

  subject { Services::Event.new(existing_event) }

  describe '#approve' do
    it 'user approve' do
      expect { subject.approve }.to change { existing_event.aasm_state }.to 'approved'
    end

    it 'user can not approve twice' do
      subject.approve
      expect { subject.approve }.to raise_exception AASM::InvalidTransition
    end
  end

  describe '#decline' do
    it 'user decline' do
      expect { subject.decline }.to change { existing_event.aasm_state }.to 'declined'
    end

    it 'user can not decline twice' do
      subject.decline
      expect { subject.decline }.to raise_exception AASM::InvalidTransition
    end
  end
end
