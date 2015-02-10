class Todo < ActiveRecord::Base

  belongs_to :project
  validates_associated :project

  belongs_to :user

  validates :body, presence: true
  validates :status, presence: true, inclusion: [0,1,2,3]

  has_many :events, :as => :evetable

end
