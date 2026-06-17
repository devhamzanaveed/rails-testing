Rails.application.routes.draw do
  root "links#index"
  resources :links, only: [:index, :create]

  # Catch-all redirect — MUST be last so it doesn't swallow other routes
  get "/:short_code", to: "redirects#show", as: :short_link
end
