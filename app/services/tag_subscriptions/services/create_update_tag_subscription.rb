# frozen_string_literal: true

# CreateUpdateTagSubscription service
# Use cases:
# - when need to create a new tag subscriptions by tag words
# examples:
# - TagSubscriptions::Services::CreateUpdateTagSubscription.new(tag_params)

module TagSubscriptions
  module Services
    # Implement CreateUpdateTagSubscription
    class CreateUpdateTagSubscription
      def initialize(tag_params)
        @tag_params = tag_params
      end

      def call
        delete_tag_subscription if tag_subscription
        create_tag_subscription
      end

      private

      def tag_subscription
        TagSubscription.find_by(email: @tag_params[:email])
      end

      def delete_tag_subscription
        tag_subscription.delete
      end

      def create_tag_subscription
        if user
          TagSubscription.create(@tag_params.merge(user_id: user.id))
        else
          TagSubscription.create(@tag_params)
        end
      end

      def user
        @user ||= User.find_by(email: @tag_params[:email])
      end
    end
  end
end
