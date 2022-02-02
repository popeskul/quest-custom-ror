# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staffs::Services::CreateStaff do
  let(:options) { attributes_for(:staff) }
  let(:options_no_password) { attributes_for(:staff) }

  let(:create_staff) { Staffs::Services::CreateStaff.new(options).call }
  let(:create_staff_with_no_password) { Staffs::Services::CreateStaff.new(options_no_password).call }

  describe '#call' do
    it 'invoke the call method and return correct object' do
      expect(create_staff.email).to eq options[:email]
    end

    it 'if no password' do
      expect(create_staff_with_no_password.email).to eq options_no_password[:email]
    end
  end
end
