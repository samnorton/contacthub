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

  match '*path', via: :all, to: 'errors#page_not_found'
end
