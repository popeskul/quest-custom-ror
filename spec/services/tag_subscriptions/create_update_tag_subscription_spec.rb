# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagSubscriptions::Services::CreateUpdateTagSubscription do
  let(:user) { create(:user) }
  let(:tag_options) { attributes_for(:tag_subscription, user_id: nil) }
  let(:new_tag_options) { tag_options.merge(tags: ['new']) }
  let(:user_tag_options) { attributes_for(:tag_subscription, email: user.email) }

  let(:tag_subscription) { TagSubscriptions::Services::CreateUpdateTagSubscription.new(tag_options).call }
  let(:tag_subscription_with_user) do
    TagSubscriptions::Services::CreateUpdateTagSubscription.new(user_tag_options).call
  end
  let(:update_tag_subscription) do
    TagSubscriptions::Services::CreateUpdateTagSubscription.new(new_tag_options).call
  end

  describe 'create' do
    it "if user doesn't exist" do
      expect(TagSubscription.find(tag_subscription.id)).to eq tag_subscription
    end

    it 'if user exist' do
      user
      expect(TagSubscription.find(tag_subscription_with_user.id).id).to eq tag_subscription_with_user.id
    end
  end

  describe 'update' do
    let(:updated_subscription) { TagSubscription.find(update_tag_subscription.id) }

    before { tag_subscription }

    it 'updated with an old email' do
      expect(updated_subscription.email).to eq tag_options[:email]
    end

    it 'updated with the new tags' do
      expect(updated_subscription.tags).to eq new_tag_options[:tags]
    end
  end
end
