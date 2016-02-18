class DeckList < ActiveRecord::Base
  belongs_to :user

  has_many :card_requirements, dependent: :destroy

  validates :title, uniqueness: { scope: :user_id }
end

