class ApplicationController < ActionController::Base
    include Pundit
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    rescue_from ActiveRecord::RecordNotFound, with: :show_404

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

    private

    def user_not_authorized
      respond_to do |format|
          format.html { redirect_to contacts_path, notice: 'You are not authorized to visit this page.' }
          format.js
      end
    end 

    def show_404
      render '404.html', status: 404
    end 
end
