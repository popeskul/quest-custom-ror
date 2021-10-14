class AddAasmStateToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :aasm_state, :string
  end
end
