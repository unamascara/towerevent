class Todo < ActiveRecord::Base

  belongs_to :project
  validates_associated :project

  belongs_to :user

  validates :body, presence: true

  # status
  # 0 paused
  # 1 started
  # 2 finished
  # 3 removed


  validates :status, presence: true, inclusion: [0,1,2,3]

  has_many :events, :as => :evetable


  after_save :create_event

  def create_event

    self.changed_attributes.each {|attr,value|

      case attr
        when 'id'
          Event.create!(body:'created todo',eventable:self)
        when 'status'
          case self.status
            when 0
              Event.create!(body:'paused todo',eventable:self) if value==1
            when 1
              Event.create!(body:'started todo',eventable:self)
            when 2
              Event.create!(body:'finished todo',eventable:self)
            else
              Event.create!(body:'removed todo',eventable:self)
          end
        when 'user_id'
          Event.create!(body:"assign to #{self.user.name}",eventable:self) if self.user
      end

    }
  end

  def url
    "/todos/#{self.id}"
  end


end
