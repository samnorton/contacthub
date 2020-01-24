class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:destroy]

  def index
    if params[:category_id] && !params[:category_id].empty?
      category_find = Category.find(params[:category_id])
      @contacts = category_find.contacts.search(params[:term]).order(created_at: :desc).page params[:page]
    else
      @contacts = Contact.search(params[:term]).order(created_at: :desc).page params[:page]
    end
      # @contact = Contact.new
  end

  def autocomplete
    if params[:category_id] && !params[:category_id].empty? 
      category_find = Category.find(params[:category_id])
      @contacts = category_find.contacts.search(params[:term]).order(created_at: :desc).page params[:page]
      render json: @contacts.map { |contact| { id: contact.id, value: contact.name }}
    else 
      @contacts = Contact.search(params[:term]).order(created_at: :desc).page params[:page]
      render json: @contacts.map { |contact| { id: contact.id, value: contact.name }}
    end
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def edit
  end

  def create
    @contact = Contact.new(contact_params)
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
