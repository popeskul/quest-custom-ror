# frozen_string_literal: true

# model User
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, class_name: 'Event'
  has_many :events, foreign_key: 'author_id', dependent: :destroy

  def author_of?(obj)
    obj.author_id == id
  end
end
