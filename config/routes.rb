Rails.application.routes.draw do
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  root to: "home#home"

  devise_for :users, :controllers => { 
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
   }

  authenticated :user, lambda {|user| user.admin? } do
    get '/allusers', to: 'admin#allusers'
    get 'approve_user/:id', to: 'admin#approve_user', as: :approve_user
    get 'reject_user/:id', to: 'admin#reject_user', as: :reject_user
  end

  patch 'update', to: 'users#update', as: :update_profile

  get "up" => "rails/health#show", as: :rails_health_check

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
