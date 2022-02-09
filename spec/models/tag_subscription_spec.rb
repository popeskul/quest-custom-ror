# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagSubscription, type: :model do
  describe 'Validations' do
    subject { build(:tag_subscription) }

    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :tags }
    it { should allow_value('user_id_num').for(:user_id) }

    it { should allow_value('good@email.com').for(:email) }
    it { should_not allow_value('bad').for(:email) }
  end

  describe 'Scopes' do
    let!(:tag) { create(:tag, name: 'ruby') }
    let(:tag_subscription) { build(:tag_subscription, tags: ['ruby']) }
    let(:tag_subscription2) { build(:tag_subscription, tags: ['another']) }

    it '.find_tags' do
      expect(TagSubscription.find_tags(tag_subscription.tags).uniq.map(&:name)).to eq ['ruby']
    end
  end
end
