Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get 'cards/index'
end
