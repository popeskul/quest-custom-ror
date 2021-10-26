# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::StaffsController, type: :controller do
  let!(:super_admin)     { create(:staff, :super_admin) }
  let!(:admin)           { create(:staff) }
  let(:existing_admins) { create_list(:staff, 2) }

  context 'GET #index' do
    describe 'authenticated admin' do
      before do
        login(admin)
        get :index
      end

      it 'returns the correct array of events' do
        expect(existing_admins).to match_array(existing_admins)
      end

      it 'renders index view' do
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #new' do
    before do
      login(super_admin)
      get :new
    end

    it 'assigns a new Event to @event' do
      expect(assigns(:staff)).to be_a_new(Staff)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { login(super_admin) }

    context 'with valid attributes' do
      subject { post :create, params: { staff: attributes_for(:staff) } }

      it 'save a new admin' do
        expect { subject }.to change(Staff, :count).by(1)
      end

      it 'redirects to show' do
        subject
        expect(response).to redirect_to admin_staffs_path
      end
    end

    context 'with invalid attributes' do
      subject { post :create, params: { staff: attributes_for(:staff, :invalid_email), format: :js } }

      it 'does not save the new admin in the database' do
        expect { subject }.to_not change(Staff, :count)
      end

      it 're-renders new view' do
        subject
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before { login(super_admin) }

    context 'Update with valid attributes' do
      let(:update_admin) { patch :update, params: { id: admin, staff: { role: 'super_admin' } } }

      it 'changes admin attributes' do
        update_admin
        admin.reload
        expect(admin.role).to eq 'super_admin'
      end

      it 'redirect to updated admin' do
        update_admin

        expect(response).to redirect_to admin_staffs_path
      end
    end

    context 'Update with invalid attributes' do
      let(:update_admin) { patch :update, params: { id: admin, staff: { role: 'invalid' }, format: :js } }

      before do
        update_admin
      end

      it 'does not change admin' do
        admin.reload
        expect(assigns(:staff)).to eq admin
      end

      it 're-renders index view' do
        expect(response).to redirect_to admin_staffs_path
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_admin) { delete :destroy, params: { id: admin } }

    context 'authenticated admin' do
      context 'deletes staff' do
        before { login(super_admin) }

        it 'successfully delete the event' do
          expect { delete_admin }.to change(Staff, :count).by(-1)
        end

        it 'successfully redirects to index' do
          delete_admin
          expect(response).to redirect_to admin_staffs_path
        end
      end
    end

    context 'not authenticated user' do
      it 'con not delete question' do
        expect { delete_admin }.to_not change(Staff, :count)
      end

      it 'redirects to login page' do
        delete_admin
        expect(response).to redirect_to new_staff_session_path
      end
    end
  end
end
