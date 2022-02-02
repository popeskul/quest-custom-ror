class CreateDeliveredUserEventsTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :events, table_name: :delivered_user_events
  end
end
