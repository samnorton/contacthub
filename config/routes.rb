Rails.application.routes.draw do
  post '/categories', to: 'categories#create'

  scope '/dashboard' do
    resources :contacts do
      collection do
        get 'autocomplete'
      end
    end
  end 
  
  root 'homepage#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
