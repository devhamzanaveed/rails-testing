Rails.application.routes.draw do
  root "links#index"
  resources :links, only: [:index, :create]

  # Rails defaults that must sit ABOVE the catch-all, or it swallows them.
  get "up" => "rails/health#show", as: :rails_health_check

  # Catch-all redirect — MUST be last so it doesn't swallow other routes
  get "/:short_code", to: "redirects#show", as: :short_link
end
