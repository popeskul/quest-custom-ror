# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeliveredTagSubscription, type: :model do
  describe 'Relations' do
    it { should belong_to(:tag_subscription) }
  end
end
