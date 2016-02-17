class Card < ActiveRecord::Base
  belongs_to :user
  
  validates :name, presence: true

  before_create :sanitize_card_name

  private

  def sanitize_card_name
    self.name.gsub!(/[^-'a-zA-Z\s]/, '')
  end
end
