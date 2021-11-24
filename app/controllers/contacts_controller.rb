class ContactsController < ApplicationController
  before_action :set_contact, only: [:edit, :update, :destroy]

  def index
    @contact = Contact.new
    @contacts = Contact.all
  end

  def edit
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("contact_#{@contact.id}",
                                                                      partial: "contacts/form",
                                                                      locals: { contact: @contact }) }
    end
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.turbo_stream
        flash_handler("notice", "Added a new contact!")
      else
        render_error_flash_message
        flash_handler("error", "Failed to add a new contact!")
      end
    end
  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.turbo_stream
        flash_handler("notice", "Successfully updated contact!")
      else
        render_error_flash_message
        flash_handler("error", "Failed to update contact!")
      end
    end
  end

  def destroy
    respond_to do |format|
      if @contact.destroy
        format.turbo_stream
        flash_handler("notice", "Successfully deleted a contact!")
      else
        render_error_flash_message
        flash_handler("error", "Failed to delete a contact!")
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

    def render_error_flash_message
      format.turbo_stream { render turbo_stream: turbo_stream.append(:flash, partial: "layouts/flash") }
    end

    def flash_handler(type, message)
      flash[type] = message
      flash.discard
    end
end
