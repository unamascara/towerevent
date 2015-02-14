class User < ActiveRecord::Base

  has_many :teamusers
  has_many :teams,:through => :teamusers

  has_many :accesses
  has_many :projects, :through => :accesses

  validates :name,:presence => true
end
