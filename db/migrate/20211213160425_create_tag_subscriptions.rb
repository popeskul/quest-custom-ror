class CreateTagSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_subscriptions do |t|
      t.string :email, null: false
      t.string :tags, null: false, array: true

      t.timestamps
    end

    add_index  :tag_subscriptions, :email, unique: true
  end
end
