Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount LetterOpenerWeb::Engine, at: '/letters' if Rails.env.development?

  namespace :api do
    post '/sign-in', to: 'sessions#create'
    post '/sign-out', to: 'sessions#destroy'
  end
end
