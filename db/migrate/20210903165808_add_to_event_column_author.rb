class AddToEventColumnAuthor < ActiveRecord::Migration[6.1]
  def change
    add_reference :events, :author, foreign_key: { to_table: :users }
  end
end
