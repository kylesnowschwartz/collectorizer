Rails.application.routes.draw do
  get 'cards/index'

  root to: "cards#index"
end
