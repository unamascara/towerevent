class Todo < ActiveRecord::Base
  belongs_to :todolist
  acts_as_list scope: :todolist

  belongs_to :project
  validates_presence_of :project
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