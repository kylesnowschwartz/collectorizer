class CreateDeckList
  def initialize(title, user)
    @user = user
    @title = title
  end

  def call
    @user.decklists.create!(title: title)
  end
end