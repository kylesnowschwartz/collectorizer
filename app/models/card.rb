class Card < ActiveRecord::Base
  validates :name, presence: true

  before_create :sanitize_card_name

  def quantity
    Card.where(name: self.name).count
  end

  private

  def sanitize_card_name
    self.name.gsub!(/[^-'a-zA-Z\s]/, '')
  end
end
