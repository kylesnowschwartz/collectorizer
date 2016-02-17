Rails.application.routes.draw do
  devise_for :users
  root to: "cards#index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resource :cards, only: [:index, :show, :new, :create, :destroy]

  resource :deck_lists, only: [:index, :show, :new, :create, :destroy] do
    resource :card_requirements, only: [:create, :destroy, :update]
  end
end
