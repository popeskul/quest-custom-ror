class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :description
      t.string :location, null: false
      t.string :organizer_email, null: false
      t.string :organizer_telegram
      t.string :link
      t.date :start_time, null: false
      t.date :end_time, null: false

      t.timestamps
    end
  end
end
