# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::UpdateStaff do
  let(:existing_admin) { create(:staff) }
  let(:new_options) { { role: 'super_admin' } }
  let(:update_staff) { Services::UpdateStaff.new(existing_admin, new_options).call }

  describe '#call' do
    it 'invoke the call method and return correct object' do
      expect(update_staff.role).to eq new_options[:role]
      expect(update_staff.email).to eq existing_admin[:email]
    end
  end
end
