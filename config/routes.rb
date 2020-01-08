Rails.application.routes.draw do
  scope '/dashboard' do
    resources :contacts
  end 
  
  root 'homepage#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
