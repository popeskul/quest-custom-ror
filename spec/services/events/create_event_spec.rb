# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Services::CreateEvent do
  let(:existing_user) { create(:user) }
  let(:options) { attributes_for(:event, event_postable: existing_user, tag_list: ['ruby']) }
  let(:event) { Events::Services::CreateEvent.new(existing_user, options).call }

  describe '#call' do
    it 'invoke the call method and return correct object' do
      expect(event.title).to eq options[:title]
      expect(event.tag_list).to eq options[:tag_list]
    end
  end
end
