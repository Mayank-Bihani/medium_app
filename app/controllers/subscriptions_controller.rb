class SubscriptionsController < ApplicationController
  before_action :authenticate_user
  
  def create
    user = current_user
    plan_id = params[:plan_id]
    payment_method = params[:payment_method]

    if user.stripe_customer_id.nil?
      customer = Stripe::Customer.create(email: user.email)
      user.update(stripe_customer_id: customer.id)
    else
      customer = Stripe::Customer.retrieve(user.stripe_customer_id)
    end

    customer_id = current_user.stripe_customer_id

    subscription = Stripe::Subscription.create({
      customer: customer_id,
      items: [{ plan: plan_id }],
      default_payment_method: payment_method
    })

    render json: { subscription: subscription }
  rescue Stripe::StripeError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end