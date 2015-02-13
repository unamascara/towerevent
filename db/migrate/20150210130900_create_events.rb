class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.references :eventable, polymorphic: true, index: true
      t.string :body
      t.timestamps
    end
  end
end
