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

    stripe_charge = Stripe::Charge.create(
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


  def destroy

    puts "insdie the destroy"
    puts current_user.stripe_id
    customer = Stripe::Customer.retrieve(
    current_user.stripe_id.to_s,
    :api_key => Stripe.api_key
    )

    if customer.delete
      flash[:notice] = "Charge was deleted."
      current_user.role = 1
      current_user.stripe_id = nil
      current_user.save
      redirect_to wikis_path
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_to charge_path
    end
  end

end
