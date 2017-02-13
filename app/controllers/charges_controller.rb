class ChargesController < ApplicationController
  skip_after_action :verify_authorized
  Stripe.api_key = ENV['SECRET_KEY']
  def new
  end

def create
  # Amount in cents
  @amount = 1500

  customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :source  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )
  current_user.role = 2
  current_user.stripe_id = customer.id
  current_user.save

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_charge_path
end

end
