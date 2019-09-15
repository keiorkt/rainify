Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "index#index"
  resources :calendars
  resources :events
  resources :weather_items
  resources :cities
end
