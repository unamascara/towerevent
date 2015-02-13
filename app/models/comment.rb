class Comment < ActiveRecord::Base
  belongs_to :commentable,:polymorphic => true
  validates :body,presence: true

  after_save :create_event

  def create_event

    self.changed_attributes.each {|attr,value|

      case attr
        when 'commentable_id'
          Event.create!(body:"commented #{self.commentable.class.to_s}",eventable:self.commentable,eventsource:self)
      end
    }

  end

  def url
    "comment/#{self.id}"
  end

end
