Rails.application.routes.draw do
  resources :bets
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   root :to => 'welcome#index'
end
