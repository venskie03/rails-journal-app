class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.text :task_description
      t.date :task_date
      t.references :category, null: true, foreign_key: true
      t.timestamps
    end
  end
end
