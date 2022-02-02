# frozen_string_literal: true

# implement WeeklyTagDigestJob
# This job call service TagSubscriptions::Services::SendWeeklyDigest
# examples:
# - WeeklyTagDigestJob.perform_later
class WeeklyTagDigestJob < ApplicationJob
  queue_as :default

  def perform
    TagSubscriptions::Services::SendWeeklyDigest.new.call
  end
end
