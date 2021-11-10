class ContactsController < ApplicationController
  before_action :set_contact, only: [:edit, :update, :destroy]

  def index
    @contact = Contact.new
    @contacts = Contact.all
  end

  def edit
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("contact_#{@contact.id}", partial: "contacts/form", locals: { contact: @contact }) }
    end
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        flash[:notice] = "Added a new contact!"
        format.turbo_stream
      else
        flash[:error] = "Failed to add a new contact!"
        format.turbo_stream { render turbo_stream: turbo_stream.append(:flash, partial: "layouts/flash") }
      end
    end
  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        flash[:notice] = "Successfully updated contact!"
        format.turbo_stream
      else
        format.html { render :index, error: "Failed to update a contact!" }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @contact.destroy
        flash[:notice] = "Successfully deleted a contact!"
        format.turbo_stream
      else
        format.html { render :index, error: "Failed to delete a contact!" }
      end
    end
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :phone_number)
    end
end
