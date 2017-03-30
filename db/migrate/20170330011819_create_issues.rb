class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.string :issue_name
      t.string :issue_decription
      t.integer :user_id
      t.integer :assign_id
      t.date :start_date
      t.date :due_date

      t.timestamps
    end
  end
end
