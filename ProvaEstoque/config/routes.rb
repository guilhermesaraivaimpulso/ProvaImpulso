Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/novoitem" => "materials#novoitem", as: :novoitem
  get "/matlogs" => "materials#matlogs", as: :matlogs
  get 'home/index'
  root 'home#index'
  resources :usuarios
  resources :materials
  resources :logs
  post "/loginusu" => "usuarios#loginusu", as: :loginusu
  post "/retirar" => "materials#retirar", as: :retirar
  post "/entrar" => "materials#entrar", as: :entrar

end
