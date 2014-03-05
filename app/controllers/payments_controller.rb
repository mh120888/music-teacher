class PaymentsController < ApplicationController
  include SessionsHelper
  def show
    @payment = Payment.find(params[:id])
    PaymentProfile.setup_client @payment.payment_profile.user
    @amount = @payment.amount
  end

  def update
    puts "&&" * 1000
    PaymentProfile.charge params
    payment = Payment.find(params[:id])
    payment.destroy
    redirect_to root_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
  end

  def create
   payment = Payment.create(amount: params[:amount], student_id: params[:student])
   current_user.payment_profiles.first.payments << payment
   redirect_to payment_profiles_path
  end
end