class Todo < ActiveRecord::Base
  belongs_to :todolist
  acts_as_list scope: :todolist

  belongs_to :project
  validates_associated :project

  belongs_to :assignee, class_name:"User",foreign_key:'user_id'

  validates :body, presence: true

  # status
  # 0 paused
  # 1 started
  # 2 finished
  # 3 removed


  validates :status, inclusion: [nil,0,1,2,3]

  has_many :events, :as => :evetable
  has_many :comments, :as => :commentable


  after_save :create_event

  def create_event

    self.changed_attributes.select{|attr|
      ['id','status','user_id','finished_at'].include?(attr)
    }.each {|attr,value|

      Event.create!(eventable:self,changed_attr:attr,old_value:value,new_value:self.send(attr))
    }
  end

  def finishes
    self.status=2
    self.save!
  end

  def url
    "/todos/#{self.id}"
  end


end
class ActiveRecord::Base
  attr_accessor :touchedBy
end