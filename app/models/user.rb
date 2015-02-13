class User < ActiveRecord::Base
  belongs_to :team
  validates_associated :team

  has_many :accesses
  has_many :projects, :through => :accesses

  validates :name,:presence => true
end
