class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :description
      t.string :location, null: false
      t.string :organizeremail, null: false
      t.string :organizertelegram
      t.string :link
      t.date :starttime, null: false
      t.date :endtime, null: false

      t.timestamps
    end
  end
end
