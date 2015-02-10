class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|

      t.belongs_to :project
      t.belongs_to :user

      t.string :body
      t.datetime :due
      t.integer :status

      t.timestamps
    end
  end
end
