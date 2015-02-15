class Comment < ActiveRecord::Base
  belongs_to :commentable,:polymorphic => true
  validates :body,presence: true

  has_many :attachments, :as => :attachable

  def url
    "comment/#{self.id}"
  end

  def eventContexts
    self.attachments
  end

end
