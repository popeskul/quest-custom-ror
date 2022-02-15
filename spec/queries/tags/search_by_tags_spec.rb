# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tags::Queries::SearchByTags do
  let(:text_for_devops) { 'docker, pg' }
  let(:tag_devops) { create(:tag, keys: 'docker, some1') }
  let!(:all_tags) { ActsAsTaggableOn::Tag.all }

  let(:search_with_tags)    { Tags::Queries::SearchByTags.new(text_for_devops, all_tags).call }
  let(:search_without_tags) { Tags::Queries::SearchByTags.new(text_for_devops, []).call }
  let(:search_without_text) { Tags::Queries::SearchByTags.new('', []).call }

  describe '#call' do
    it 'invoke and call with the tags and return correct array' do
      tag_devops
      expect(search_with_tags).to eq [tag_devops]
    end

    it 'invoke and call with empty tags' do
      expect(search_without_tags).to eq []
    end

    it 'invoke and call with empty text' do
      expect(search_without_text).to eq []
    end
  end
end
