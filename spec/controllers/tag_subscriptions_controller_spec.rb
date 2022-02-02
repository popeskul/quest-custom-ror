# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagSubscriptionsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:staff) }
  let(:tag_subscription) { create(:tag_subscription) }

  describe 'GET #new' do
    before do
      login(user)
      get :new
    end

    it 'assigns a new TagSubscription to @tag_subscription' do
      expect(assigns(:tag_subscription)).to be_a_new(TagSubscription)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      subject { post :create, params: { tag_subscription: attributes_for(:tag_subscription) } }

      it 'save a new tag subscription' do
        expect { subject }.to change(TagSubscription, :count).by(1)
      end

      it 'redirects to show' do
        subject
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
      subject do
        post :create, params: { tag_subscription: attributes_for(:tag_subscription, :invalid_tags), format: :js }
      end

      it 'does not save the new tag subscription in the database' do
        expect { subject }.to_not change(TagSubscription, :count)
      end

      it 're-renders new view' do
        subject
        expect(response).to render_template :new
      end
    end
  end
end
