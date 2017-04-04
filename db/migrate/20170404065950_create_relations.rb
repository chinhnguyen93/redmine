class CreateRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :relations do |t|
      t.integer :assign_id
      t.integer :project_id
      t.timestamps
    end
  end
end
