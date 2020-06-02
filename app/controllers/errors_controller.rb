class ErrorsController < ApplicationController
    def show_404
        render "404", status: 404
      end 
end 