class PaymentProfilesController < ApplicationController
  include StripeHelper
  include SessionsHelper


  def create
    PaymentProfile.charge params
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payment_profiles_path
  end

  def index
    @user = username Stripe::Account
    @connected = PaymentProfile.setup_client current_user
    @payments = Stripe::Charge.all
    @plans = Stripe::Plan.all
    current_payment_profile = current_user.payment_profiles.first
    @outstanding = current_payment_profile.payments if current_payment_profile
  end

  def connect
    PaymentProfile.access_client_account params[:code], current_user
    redirect_to payment_profiles_path
  end
end