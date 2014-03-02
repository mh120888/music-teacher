class PaymentProfilesController < ApplicationController
  include StripeHelper

  def new
    @plans = Stripe::Plan.all
    render :new, :layout => false
  end

  def create
    PaymentProfile.charge params
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payment_profiles_path
  end

  def index
    @user = username Stripe::Account
    @connected = session[:connected]
    @payments = Stripe::Charge.all
    @plans = Stripe::Plan.all
  end

  def connect
    PaymentProfile.access_client_account params[:code]
    session[:connected] = true
    redirect_to payment_profiles_path
  end
end