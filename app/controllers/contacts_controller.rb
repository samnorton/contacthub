class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:destroy]
  before_action :authenticate_user!

  def index
    @contacts = current_user.contacts.order(created_at: :desc).page(params[:page])
    @contacts = @contacts.where(category_id: params[:category_id]) if params[:category_id].present?
    @contacts = @contacts.search(params[:term]) if params[:term].present?
  end

  def autocomplete
      @contacts = current_user.contacts.order(created_at: :desc).page(params[:page])
      @contacts = @contacts.where(category_id: params[:category_id]) if params[:category_id].present?
      @contacts = @contacts.search(params[:term]) if params[:term].present?
      render json: @contacts.map { |contact| { id: contact.id, value: contact.name }}
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def edit
    authorize @contact
  end

  def create
    @contact = current_user.contacts.build.(contact_params)
    @success = @contact.save ? true : false

    respond_to do |format|
      if @success
        format.html { redirect_to contacts_path, notice: 'Contact was successfully created.' }
        format.js
      else
        format.js
      end
    end
  end

  def update
    @success = @contact.update(contact_params) ? true : false

    respond_to do |format|
      if @success
        format.html { redirect_to contacts_path, notice: 'Contact was successfully updated.' }
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    authorize @contact
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :mobile, :phone, :country, :address, :city, :state, :zip, :note, :category_id, :contact_avatar)
    end

    def has_error?(resource, field)
      resource.errors.messages[field].present?
    end

    def get_error(resource, field)
      msg = resource.errors.messages[field]
      field.to_s.capitalize + " " + msg.join(' and ') + '.'
    end

    helper_method :has_error?
    helper_method :get_error
end
