class Event < ActiveRecord::Base

  # who this event is about
  belongs_to :eventable,:polymorphic => true

  # add eventsource to event to indicate the context where the event is created
  belongs_to :eventsource,:polymorphic => true


  belongs_to :creator, class_name:"User",foreign_key:'creator_id'

  def body
    case eventable.class.to_s
      when 'Todo'
        case changed_attr
          when 'id'
            'created todo'
          when 'status'

            case new_value
              when '0'
                'paused todo'
              when '1'
                'started todo'
              when '2'
                'finished todo'
              when '3'
                'removed todo'
            end
          when 'user_id'
            if old_value==''
              "assign to #{eventable.assignee.name}"
            else
              oldUser = User.find(old_value)
              "change assignee from #{oldUser.name} to #{eventable.assignee.name}"
            end
          when 'finished_at'
            "change finished time from #{old_value} to #{new_value}"
          when 'comments'
            "commented #{self.eventable.class.to_s}"
        end

    end


  end
end
