class AddProjectIdToIssues < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :project_id, :integer
  end
end
