Rails.application.routes.draw do
  root to: 'power_generators#index'

  resources :home, only: %i[index]

  resources :power_generators, only: %i[index show] do
    get 'search', on: :collection
    get 'simple_search', on: :collection
    get 'advanced_search', on: :collection
    get 'freight_calculate', on: :member
  end

  resources :freights, only: %i[index]
end
