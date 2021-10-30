# frozen_string_literal: true

# Admin namespace for UsersController
module Admin
  # implement UsersController
  class StaffsController < Admin::BaseController
    include AuthorizationUtils

    before_action :find_staff, only: %i[update destroy]
    before_action :check_event_policy

    def index
      @staffs = Staff.order(:created_at).page(params[:page])
    end

    def new
      @staff = Staff.new
    end

    def create
      options = params.require(:staff).permit(:email)

      @staff = Services::CreateStaff.new(options).call

      if @staff.save
        redirect_to admin_staffs_path, notice: t('.success')
      else
        render :new
      end
    end

    def edit; end

    def update
      options = params.require(:staff).permit(:role)

      if @staff.update(options)
        redirect_to admin_staffs_url, notice: t('.success')
      else
        redirect_to admin_staffs_path
      end
    end

    def destroy
      @staff.destroy
      redirect_to admin_staffs_path, notice: t('.success')
    end

    private

    def find_staff
      @staff = Staff.find(params[:id])
    end

    def check_event_policy
      check_policy Admin::StaffPolicy, @staff
    end
  end
end
