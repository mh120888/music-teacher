class PaymentsController < ApplicationController
  include StripeHelper

  def new
    render :new, :layout => false
  end

  def create
    charge_payment params
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payments_path
  end

  def index
    @user = username Stripe::Account
    @connected = session[:connected]
    @payments = Stripe::Charge.all
  end

  def connect
    access_client_account params[:code]
    session[:connected] = true
    redirect_to payments_path
  end
end