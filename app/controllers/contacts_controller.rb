class ContactsController < ApplicationController
  def index
    @contact = Contact.new
    @contacts = Contact.all#orderati ih po abecednom redu
  end

  def edit#uraditi pomoću turbo-a, kreirati edit template i po potrebi ga renderati
    respond_to do |format|
      if @contact.save
        flash[:notice] = "Added a new contact!"
        format.turbo_stream
      else
        flash[:error] = "Failed to add a new contact!"
        format.turbo_stream { render turbo_stream: turbo_stream.append(:flash, partial: "layouts/flash") }
        #format.html { render :index, error: "Failed to add a new contact!" }
      end
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
        #format.html { render :index, error: "Failed to add a new contact!" }
      end
    end
  end

  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update(contact_params)
        format.html { status :ok, notice: "Successfully updated a contact!" }
        redirect_to root_path
      else
        format.html { render :index, error: "Failed to update a contact!" }
      end
    end
  end

  def destroy
    @contact = Contact.find(params[:id])

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
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :phone_number)
    end
end
