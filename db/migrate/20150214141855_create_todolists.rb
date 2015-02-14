class CreateTodolists < ActiveRecord::Migration
  def change
    create_table :todolists do |t|
      t.string :name
      t.timestamps
    end

    add_reference :todos, :todolist
    add_column :todos,:position,:integer
  end

end
