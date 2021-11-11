class HistoriesController < ApplicationController
  before_action :set_contact, only: [:update, :destroy]

  def update
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    respond_to do |format|
      format.turbo_stream
    end
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end
end
