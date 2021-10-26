# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::CreateStaff do
  let(:options) { attributes_for(:staff) }
  let(:create_staff) { Services::CreateStaff.new(options).call }

  describe '#call' do
    it 'invoke the call method and return correct object' do
      expect(create_staff.email).to eq options[:email]
    end
  end
end
