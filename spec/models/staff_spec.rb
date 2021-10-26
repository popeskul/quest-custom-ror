# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staff, type: :model do
  include_examples 'model has relations'

  include_examples 'model has validations'

  describe 'has role' do
    let(:staff) { create(:staff) }

    it { expect(staff).to have_state(:admin) }

    describe 'move to super admin' do
      it { expect(staff).to transition_from(:admin).to(:super_admin).on_event(:change_to_super_admin) }
    end

    describe 'move to admin' do
      it { expect(staff).to transition_from(:super_admin).to(:admin).on_event(:change_to_admin) }
    end
  end
end
