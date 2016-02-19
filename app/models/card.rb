class Card < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true

  scope :with_multiverse_id, ->(multiverse) { where(multiverse: multiverse) }
end
