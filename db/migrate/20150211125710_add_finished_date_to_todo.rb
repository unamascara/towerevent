class AddFinishedDateToTodo < ActiveRecord::Migration
  def change
    add_column :todos,:finished_at,:datetime
  end
end
