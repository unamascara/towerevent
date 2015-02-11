class Event < ActiveRecord::Base

  # who this event is about
  belongs_to :eventable,:polymorphic => true
  
  # add eventsource to event to indicate the context where the event is created
  belongs_to :eventsource,:polymorphic => true
end
