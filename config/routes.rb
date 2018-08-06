Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount LetterOpenerWeb::Engine, at: '/letters' if Rails.env.development?

  namespace :api do
    devise_for(
      :users,
      path: 'auth',
      path_names: {
        sign_in: 'sign-in',
        sign_out: 'sign-out',
      },
      controllers: {
        sessions: 'api/sessions'
      }
    )
  end
end
