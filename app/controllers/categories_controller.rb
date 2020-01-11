class CategoriesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        @category = Category.new(category_params)

        if @category.save
           render json: @category, status: :created
        else
           render json: @group.errors.full_messages, status: :unprocessable_entity
        end
    end
<<<<<<< HEAD
    
=======

>>>>>>> 36f61cab7990b9fd65003a64e7c60ebc568db660
    private

    def category_params
        params.require(:category).permit(:name)
    end
end
