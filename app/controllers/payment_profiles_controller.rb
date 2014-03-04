class PaymentProfilesController < ApplicationController
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
    @connected = PaymentProfile.setup_client current_user
    @payments = Stripe::Charge.all
    @plans = Stripe::Plan.all
    @outstanding = current_user.payment_profiles.first.payments if current_user.payment_profiles.first
      render 'index', layout: false and return if request.xhr?
  end

  def index_partial
    @user = username Stripe::Account
    @connected = PaymentProfile.setup_client current_user
    @payments = Stripe::Charge.all
    @plans = Stripe::Plan.all
    @outstanding = current_user.payment_profiles.first.payments if current_user.payment_profiles.first
    render 'index', layout: false
  end

  def connect
    PaymentProfile.access_client_account params[:code], current_user
    redirect_to payment_profiles_path
  end
end
