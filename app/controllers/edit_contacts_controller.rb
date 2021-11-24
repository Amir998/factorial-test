class EditContactsController < ApplicationController
  before_action :set_contact, only: [:update, :destroy]

  def update
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("contact_#{@contact.id}",
                                                                      partial: "contacts/edit",
                                                                      locals: { contact: @contact }) }
    end
  end

  def destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("edit_form_#{@contact.id}",
                                                                      partial: "contacts/contact",
                                                                      locals: { contact: @contact }) }
    end
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end
end
