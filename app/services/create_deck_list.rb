class CreateDeckList
  def initialize(title, user)
    @user = user
    @title = title
  end

  def call
    @user.deck_lists.create!(title: @title)
  endend
