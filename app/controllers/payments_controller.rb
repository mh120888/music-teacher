class PaymentsController < ApplicationController
  def new

  end

  def create
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      :email => 'example@stripe.com',
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

  def index
    @connected = true if session[:connected]
  end

  def connect
    Stripe.api_key = Payment.get_payment_access(params[:code])['access_token']
    session[:connected] = true
    redirect_to payments_path
  end

end