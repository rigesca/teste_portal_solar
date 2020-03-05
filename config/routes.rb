Rails.application.routes.draw do
  root to: 'power_generators#index'

  resources :home, only: %i[index]

  resources :power_generators, only: %i[index show] do
    get 'search', on: :collection
  end
end
