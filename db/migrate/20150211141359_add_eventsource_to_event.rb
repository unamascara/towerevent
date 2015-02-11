class AddEventsourceToEvent < ActiveRecord::Migration
  def change
    add_reference :events,:eventsource, polymorphic: true, index: true
  end
end
