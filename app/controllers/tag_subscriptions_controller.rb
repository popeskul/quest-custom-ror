# frozen_string_literal: true

# TagSubscriptions Controller
class TagSubscriptionsController < ApplicationController
  include AuthorizationUtils

  before_action :find_tags, only: %i[new create]
  before_action :check_tag_subscription_policy

  def new
    @tag_subscription = TagSubscription.new
  end

  def create
    @tag_subscription = TagSubscriptions::Services::CreateUpdateTagSubscription.new(tag_subscription_params).call

    if @tag_subscription.valid?
      create_user unless User.find_by(email: @tag_subscription.email)
      send_subscription_email

      redirect_to root_path, notice: t('.success')
    else
      render :new
    end
  end

  private

  def tag_subscription_params
    params.require(:tag_subscription).permit(:email, tags: [])
  end

  def find_tags
    @tags = ActsAsTaggableOn::Tag.all
  end

  def create_user
    User.create(
      email: @tag_subscription.email, password: User.generate_token, reset_password_token: User.generate_token
    )
    UserMailer.signup_by_email(@tag_subscription.email).deliver_now
  end

  def check_tag_subscription_policy
    check_policy TagSubscriptionPolicy, @tag_subscription
  end

  def send_subscription_email
    TagSubscriptionMailer.subscription_created(@tag_subscription).deliver_later
  end
end
