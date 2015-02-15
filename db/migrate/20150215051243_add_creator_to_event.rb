class AddCreatorToEvent < ActiveRecord::Migration
  def change
    add_reference :events,:creator
  end
end
