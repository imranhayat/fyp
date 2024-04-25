Rails.application.routes.draw do
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  root to: "home#home"

  get '/learners/searchlocation', to: 'learners#searchlocation'
  get '/learners/allbookings', to: 'learners#allbookings'
  get '/learners/createbooking/:school_id', to: 'learners#createbooking'
  get '/instructors/allbookings', to: 'instructors#allbookings'
  get '/schools/allbookings', to: 'schools#allbookings'
  get '/schools/allinstructors', to: 'schools#allinstructors'
  get '/schools/alllessons', to: 'schools#alllessons'
  get '/schools/createlesson/:school_id', to: 'schools#createlesson'
  post '/schools/edit_lesson/:lesson_id', to: 'schools#edit_lesson'
  get '/schools/delete_lesson/:lesson_id', to: 'schools#delete_lesson'
  get 'update_booking_status/:id', to: 'learners#update_booking_status', as: :update_booking_status

  post '/learners/add_review/:lesson_id', to: 'learners#add_review'

  devise_for :users, :controllers => { 
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
   }

  authenticated :user, lambda {|user| user.admin? || user.school? } do
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
