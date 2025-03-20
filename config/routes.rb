Rails.application.routes.draw do
  get "genres/index"
  get "genres/show"
  get "albums/index"
  get "albums/show"
  # About Page Route
  get 'about', to: 'pages#about', as: :about

  # Health status and PWA routes (do not modify these)
  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Root route
  root 'singers#index'

  # Singers Routes with nested Songs
  resources :singers, only: [:index, :show] do
    resources :songs, only: [:index, :show]
  end

  # Additional routes for Albums and Genres (optional but useful for navigation)
  resources :albums, only: [:index, :show]
  resources :genres, only: [:index, :show]
end
