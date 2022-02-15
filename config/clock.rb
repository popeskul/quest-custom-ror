require './config/boot'
require './config/environment'

require 'clockwork'
require 'active_support/time'

module Clockwork
  # handler do |job|
  #   puts "Running #{job}"
  # end

  every(3.minutes, 'Weekly Job - WeeklyTagDigestJob', :at => 'Friday 09:00') do
    WeeklyTagDigestJob.perform_later
  end
end
