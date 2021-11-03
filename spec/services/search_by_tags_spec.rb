# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::SearchByTags do
  let(:text) { 'ruby docker pg 1' }
  let(:tag_names) { %w[ruby dev docker] }

  let(:search_with_tags)    { Services::SearchByTags.new(text, tag_names).call }
  let(:search_without_tags) { Services::SearchByTags.new(text, []).call }
  let(:search_without_text) { Services::SearchByTags.new('', []).call }

  describe '#call' do
    it 'invoke and call with the tags and return correct array' do
      expect(search_with_tags).to eq [tag_names[0], tag_names[2]]
    end

    it 'invoke and call with empty tags' do
      expect(search_without_tags).to eq []
    end

    it 'invoke and call with empty text' do
      expect(search_without_text).to eq []
    end
  end
end
