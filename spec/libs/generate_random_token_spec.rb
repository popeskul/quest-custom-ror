# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GenerateRandomToken do
  subject { GenerateRandomToken.call }

  it '#call' do
    expect(subject).to have_attributes(size: 20)
  end
end
