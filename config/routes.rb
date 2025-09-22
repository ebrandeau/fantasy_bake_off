Rails.application.routes.draw do
  root "sessions#new"

  resource :session, only: %i[new create destroy]

  resources :seasons do
    member do
      get :leaderboard
    end

    resources :episodes do
      resources :picks, only: %i[new create edit update destroy]
      resource  :result, only: [:show, :new, :create, :edit, :update]
    end

    resources :contestants
    resources :overall_picks, only: %i[new create edit update]
  end

  resources :users
end
