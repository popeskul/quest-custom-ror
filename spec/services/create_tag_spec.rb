# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::CreateTag do
  let(:options) { attributes_for(:tag) }
  let(:create_tag) { Services::CreateTag.new(options).call }

  describe '#call' do
    it 'invoke the call method and return correct object' do
      expect(create_tag.name).to eq options[:name]
    end
  end
end
