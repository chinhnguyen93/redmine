class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.references :issue, foreign_key: true
      t.string :log_description

      t.timestamps
    end
  end
end
