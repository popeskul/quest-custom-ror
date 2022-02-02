# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staff, type: :model do
  describe 'Relations' do
    it { should have_many(:events).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  describe 'Aasm state' do
    let(:staff) { create(:staff) }

    it { expect(staff).to have_state(:admin) }

    describe 'move to super admin' do
      it { expect(staff).to transition_from(:admin).to(:super_admin).on_event(:change_to_super_admin) }
    end

    describe 'move to admin' do
      it { expect(staff).to transition_from(:super_admin).to(:admin).on_event(:change_to_admin) }
    end
  end

  describe 'Scopes' do
    let(:admin) { create(:staff, :admin) }
    let(:super_admin) { create(:staff, :super_admin) }

    it '.for_super_admin' do
      super_admin
      expect(Staff.for_super_admin.uniq.first).to eq super_admin
    end

    it '.for_admin' do
      admin
      expect(Staff.for_admin.uniq.first).to eq admin
    end
  end
end
