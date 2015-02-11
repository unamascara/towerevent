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
          when 'body'
        end
      }
  end

  def url
    "/todos/#{self.id}"
  end


end
