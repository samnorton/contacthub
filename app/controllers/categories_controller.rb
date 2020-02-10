class CategoriesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        @category = current_user.categories.build(category_params)

        if @category.save
           render json: @category, status: :created
        else
           render json: @group.errors.full_messages, status: :unprocessable_entity
        end
    end
    
    private

    def category_params
        params.require(:category).permit(:name)
    end
end
