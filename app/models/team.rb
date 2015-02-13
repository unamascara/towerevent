class Team < ActiveRecord::Base
  has_many :projects
  has_many :users

  validates :name, presence: true
end
