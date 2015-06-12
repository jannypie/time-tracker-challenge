Rails.application.routes.draw do
  root 'application#index'

  devise_for :users

  resources :time_entries, only: %i(index create show update destroy)

  resources :companies,  only: %i(index create show update destroy) do
    resources :projects, only: %i(index create show update destroy)
    resources :tasks,    only: %i(index create show update destroy)
  end
end
