class AddCreatorIdToLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :logs, :creator_id, :integer
  end
end
