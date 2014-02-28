class PaymentsController < ApplicationController
  include PaymentHelper

  def new
    render :new, :layout => false
  end

  def create
    charge(params)
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payments_path
  end

  def index
    @user = Stripe::Account.retrieve.display_name
    @connected = true if session[:connected]
    @payments = Stripe::Charge.all
  end

  def connect
    client_info = get_client_info(params[:code])
    get_client_access(client_info)
    session[:connected] = true
    redirect_to payments_path
  end
end