Rails.application.routes.draw do
  # users
  get "/users", to: "users#index"
  post "/signup", to: "users#create"
  get "/users/:id", to: "users#show"
  put "/users/:id", to: "users#update"

  # sessions
  post "/login", to: "sessions#login"
  delete "/logout", to: "sessions#logout"
  get "/check", to: "sessions#logged_in"
end
