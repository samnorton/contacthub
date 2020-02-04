class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
       stored_location_for(resource) || contacts_path
    end

    def after_sign_up_path_for(resource)
       after_sign_in_path_for(resource)
    end

     protected

          def configure_permitted_parameters
               devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:user_avatar, :name, :email, :password, :password_confirmation)}

               devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:user_avatar, :name, :email, :password, :current_password)}
          end
end
