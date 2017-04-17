class AddPriorityToIssues < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :priority, :string
  end
end
