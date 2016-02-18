Rails.application.routes.draw do
  devise_for :users
  root to: "cards#index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :cards, only: [:index, :show, :create, :destroy]

  resources :deck_lists, only: [:index, :show, :create, :destroy] do
    resources :card_requirements, only: [:create, :destroy, :update]
  end
end
