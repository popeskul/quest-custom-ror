# frozen_string_literal: true

require 'rails_helper'

shared_examples_for 'model has relations' do
  describe 'Relations' do
    it { should have_many(:events).dependent(:destroy) }
  end
end

shared_examples_for 'model has validations' do
  describe 'Validations' do
    it { should validate_presence_of :email }

    it { should validate_presence_of :password }
  end
end
