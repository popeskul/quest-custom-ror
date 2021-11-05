class AddKeysToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :keys, :string
  end
end
