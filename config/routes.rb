Rails.application.routes.draw do
  resources :nivels
  get 'control_users/index'
  get 'alunos/index'
  get 'professores/index'
  get 'administradores/index'
  root "index#index"
  devise_for :users
 
 #devise_scope :user do
  #root :to => 'devise/sessions#new'
 #end
  
   
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end