Rails.application.routes.draw do

  # resources :submissions
  # resources :themes
  # resources :questions
  # resources :users
  # get 'q/:id' => 'dc#question'
  # get 't/:id' => 'dc#theme'
  # get 'leaderboard' => 'dc#leaderboard'
  get 'rules' => 'dc#rules'
  get 'login' => 'dc#login'
  # get 'about' => 'dc#about'
  get 'register' => 'dc#register'
  # get 'clear' => 'dc#clear'
  # get '' => 'dc#login'

end
