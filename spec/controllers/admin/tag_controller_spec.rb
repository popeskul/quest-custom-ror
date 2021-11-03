# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::TagsController, type: :controller do
  let(:user_adam) { create(:staff) }

  let!(:existing_tag) { create(:tag) }

  context 'GET #index' do
    before do
      login(user_adam)
      get :index
    end

    it 'returns the correct array of tags' do
      expect(existing_tag).to eq existing_tag
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before do
      login(user_adam)
      get :new
    end

    it 'assigns a new Tag to @tag' do
      expect(assigns(:tag)).to be_a_new(ActsAsTaggableOn::Tag)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { login(user_adam) }

    context 'with valid attributes' do
      subject { post :create, params: { acts_as_taggable_on_tag: attributes_for(:tag) } }

      it 'save a new tag' do
        expect { subject }.to change(ActsAsTaggableOn::Tag, :count).by(1)
      end

      it 'redirects to all tags' do
        subject
        expect(response).to redirect_to admin_tags_path
      end
    end

    context 'with invalid attributes' do
      subject { post :create, params: { acts_as_taggable_on_tag: attributes_for(:tag, :invalid), format: :js } }

      it 'does not save the new tag in the database' do
        expect { subject }.to_not change(ActsAsTaggableOn::Tag, :count)
      end

      it 're-renders new view' do
        subject
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user_adam) }

    context 'Update with valid attributes' do
      let(:update_tag) { patch :update, params: { id: existing_tag.id, acts_as_taggable_on_tag: { name: 'new' } } }

      it 'changes admin attributes' do
        update_tag
        existing_tag.reload
        expect(existing_tag.name).to eq 'new'
      end

      it 'redirect to updated tag' do
        update_tag
        expect(response).to redirect_to admin_tags_path
      end
    end

    context 'Update with invalid attributes' do
      let(:update_tag) do
        patch :update, params: { id: existing_tag.id, acts_as_taggable_on_tag: { name: nil }, format: :js }
      end

      before { update_tag }

      it 'does not change tag' do
        existing_tag.reload
        expect(assigns(:tag)).to eq existing_tag
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_tag) { delete :destroy, params: { id: existing_tag.id } }

    context 'authenticated admin' do
      context 'deletes staff' do
        before { login(user_adam) }

        it 'successfully delete the event' do
          expect { delete_tag }.to change(ActsAsTaggableOn::Tag, :count).by(-1)
        end

        it 'successfully redirects to index' do
          delete_tag
          expect(response).to redirect_to admin_tags_path
        end
      end
    end

    context 'not authenticated user' do
      it 'con not delete question' do
        expect { delete_tag }.to_not change(ActsAsTaggableOn::Tag, :count)
      end

      it 'redirects to login page' do
        delete_tag
        expect(response).to redirect_to new_staff_session_path
      end
    end
  end
end
