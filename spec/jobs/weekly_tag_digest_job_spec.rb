# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeeklyTagDigestJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later }

  it 'executes perform' do
    expect_any_instance_of(TagSubscriptions::Services::SendWeeklyDigest).to receive(:call).with(no_args)
    perform_enqueued_jobs { job }
  end

  it 'queues the job' do
    expect { job }.to have_enqueued_job(described_class).with(no_args).on_queue('default')
  end
end
