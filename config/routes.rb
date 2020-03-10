Rails.application.routes.draw do
  root 'homepage#index'
  
  post '/categories', to: 'categories#create'

  scope '/dashboard' do
    resources :contacts do
      collection do
        get 'autocomplete'
      end
    end
  end 


  scope '/dashboard' do
    resources :users 
  end 

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
