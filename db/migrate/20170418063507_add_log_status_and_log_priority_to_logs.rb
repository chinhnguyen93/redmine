class AddLogStatusAndLogPriorityToLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :logs, :log_status, :string
    add_column :logs, :log_priority, :string
  end
end
