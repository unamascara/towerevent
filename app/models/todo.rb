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
          if value.nil?
            Event.create!(body:"assign to #{self.user.name}",eventable:self)
          else
            oldUser = User.find(value)
            Event.create!(body:"change assignee from #{oldUser.name} to #{self.user.name}",eventable:self)
          end
        when 'finished_at'
          Event.create!(body:"change finished time from #{value} to #{self.finished_at}",eventable:self) if value
      end

    }
  end

  def finishes
    self.status=2
    self.finished_at=Time.now
    self.save!
  end

  def url
    "/todos/#{self.id}"
  end


end
