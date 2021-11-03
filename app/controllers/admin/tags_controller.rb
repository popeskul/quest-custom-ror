# frozen_string_literal: true

# Admin namespace for TagsController
module Admin
  # implement TagsController
  class TagsController < Admin::BaseController
    include AuthorizationUtils

    before_action :find_tag, only: %i[edit update destroy]
    before_action :check_tag_policy

    def index
      @tags = ActsAsTaggableOn::Tag.all
    end

    def new
      @tag = helpers.new_tag
    end

    def create
      @tag = Services::CreateTag.new(tag_params).call

      if @tag.save
        redirect_to admin_tags_path, notice: t('.success')
      else
        render :new
      end
    end

    def edit; end

    def update
      if @tag.update(tag_params)
        redirect_to admin_tags_path, notice: t('.success')
      else
        render :edit
      end
    end

    def destroy
      @tag.destroy
      redirect_to admin_tags_path, notice: t('.success')
    end

    private

    def find_tag
      @tag = helpers.find_tag(params[:id])
    end

    def check_tag_policy
      check_policy Admin::TagPolicy, @staff
    end

    def tag_params
      params.require(:acts_as_taggable_on_tag).permit(:name)
    end
  end
end
