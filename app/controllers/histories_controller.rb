class HistoriesController < ApplicationController
  before_action :set_contact, only: [:update, :destroy]

  def update
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.append("contact_#{@contact.id}",
                                                                    partial: "contacts/history",
                                                                    locals: { contact: @contact }) }
    end
  end

  def destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("contact_history_#{@contact.id}") }
    end
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end
end
