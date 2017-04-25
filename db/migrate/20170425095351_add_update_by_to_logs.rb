class AddUpdateByToLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :logs, :update_by, :integer
  end
end
