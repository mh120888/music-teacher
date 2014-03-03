class PaymentsController < ApplicationController
  include SessionsHelper
  def show
    @payment = Payment.find(params[:id])
    PaymentProfile.setup_client @payment.payment_profile.user
    @amount = @payment.amount
  end

  def update
    PaymentProfile.charge params
    payment = Payment.find(params[:id])
    payment.destroy
    render :thank_you
  rescue Stripe::CardError => e
    flash[:error] = e.message
  end

  def create
   payment = Payment.create(amount: params[:amount])
   current_user.payment_profiles.first.payments << payment
   @url = "localhost:3000" + payment_path(payment)
   redirect_to payment_profiles_path
  end
end