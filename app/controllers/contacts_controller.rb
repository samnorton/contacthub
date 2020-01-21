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

    respond_to do |format|
      if @contact.save
        format.html { redirect_to contacts_path, notice: 'Contact was successfully created.' }
        # format.json { render :show, status: :created, location: @contact }
        format.js
      else
        #Todo: Handle this code block when there are errors, redirect to create modal so that errors are displayed over there
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to contacts_path, notice: 'Contact was successfully updated.' }
        # format.json { render :show, status: :ok, location: @contact }
        format.js
      else
        #Todo: Replicate same logic implemented in create when there are errors
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
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
end
