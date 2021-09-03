# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :title, :body, presence: true
end
