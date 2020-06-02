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

  match '*path', via: :all, to: 'errors#show_404', constraints: lambda { |req|
  req.path.exclude? 'rails/active_storage'
}

end
