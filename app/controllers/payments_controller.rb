class PaymentsController < ApplicationController
  def show
    @payment = Payment.find(params[:id])
    PaymentProfile.setup_client @payment.payment_profile.user
    @amount = @payment.amount
  end

  def update
    PaymentProfile.charge params
    # repeating line, move it to a before_filter
    payment = Payment.find(params[:id])
    payment.destroy
    render :thank_you
  rescue Stripe::CardError => e
    flash[:error] = e.message
  end

  def create
  # you're handling the happy path only, what happens if you couldn't update_payment profile?
   payment = Payment.create(amount: params[:amount])
   current_user.update_payment_profile payment
   @url = payment_url(payment)
   redirect_to payment_profiles_path
  end
end
