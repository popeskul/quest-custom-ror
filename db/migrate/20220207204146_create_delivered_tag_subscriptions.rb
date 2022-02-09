class CreateDeliveredTagSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :delivered_tag_subscriptions do |t|
      t.string :tag_subscription_id, null: false
      t.string :email, null: false
      t.string :event_ids, null: false, array: true

      t.timestamps
    end
  end
end
