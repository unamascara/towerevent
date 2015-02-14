class CreateTeamusers < ActiveRecord::Migration
  def change
    create_table :teamusers do |t|
      t.belongs_to :team, index: true
      t.belongs_to :user, index: true
      t.belongs_to :role, index: true

      t.timestamps
    end
  end
end
