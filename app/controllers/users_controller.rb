class UsersController < ApplicationController
    before_action :authenticate_user, except: [:register]
    
    def create_stripe_customer
      customer = Stripe::Customer.create({
        email: email,
        description: username, 
      })
      update(stripe_customer_id: customer.id)
    end
  
    def stripe_customer
      return nil unless stripe_customer_id
  
      Stripe::Customer.retrieve(stripe_customer_id)
    end
    
  end
  