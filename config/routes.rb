Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  defaults format: :json do
    resources :members, only: %i[show index create update] do
      get 'search', to: 'members#search'
    end
  end
end
