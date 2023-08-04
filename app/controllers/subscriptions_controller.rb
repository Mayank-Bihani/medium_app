class SubscriptionsController < ApplicationController
    before_action :authenticate_user
  
    def create
      user = current_user
      
      if user.stripe_customer_id.nil?
        # Create a Stripe customer
        customer = Stripe::Customer.create(email: user.email)
        puts user.name
        # Save the Stripe customer ID to the user's record
        user.update(stripe_customer_id: customer.id)
      else
        customer = Stripe::Customer.retrieve(user.stripe_customer_id)
      end
  
      # Create a subscription
      subscription = customer.subscriptions.create(
        items: [{ price: params[:plan_id] }]
      )
  
      render json: { subscription: subscription }
    rescue Stripe::StripeError => e
      render json: { error: e.message }, status: :bad_request
    end
end
  