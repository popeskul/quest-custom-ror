class ChangeEventsToPolymorphic < ActiveRecord::Migration[6.1]
  def change
    change_table :events do |t|
      t.references :event_postable, polymorphic: true
    end
  end
end
