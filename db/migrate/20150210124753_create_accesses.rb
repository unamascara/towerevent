class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.belongs_to :user
      t.belongs_to :project
      t.timestamps
    end
  end
end
