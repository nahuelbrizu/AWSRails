Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # root "posts#index"
end
