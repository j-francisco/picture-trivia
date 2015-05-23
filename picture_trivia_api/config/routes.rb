Rails.application.routes.draw do

  root 'sessions#login'

  post 'user_login' => 'sessions#login'

  resources :questions

  post 'games' => 'games#new'

  get 'games/:id' => 'games#view'

  put 'submit_answer' => 'user_games#answer'

end
