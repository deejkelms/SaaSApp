class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    name = params[:contact][:name]
    email = params[:contact][:email]
    body = params[:contact][:comments]
    
    ContactMailer.contact_email(name, email, body).deliver
    
      if @contact.save
        flash[:success] = "New User Created!"
        redirect_to new_contact_path
      else
        flash[:danger] = "Not enough information :("
        redirect_to new_contact_path
      end
  end
  
  private
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end