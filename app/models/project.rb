class Project < ActiveRecord::Base

  belongs_to :team
  validates_associated :team

  has_many :accesses
  has_many :users, :through => :accesses

  has_many :todos

  validates :name, presence: true
end
