class ContactsController < ApplicationController

  def index;  end
  def new
    @contact = Contact.new(params[:contact])
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:notice] = t('mail-true')
    else
      flash.now[:error] = t('mail-false')
      render :new
    end
  end
end
