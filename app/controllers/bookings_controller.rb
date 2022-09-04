# frozen_string_literal: true

class BookingsController < ApplicationController
  before_action :require_login

  def create
    @cart.each do |item|
      return redirect_to cart_index_path, alert: item.errors.messages if item.already_booked?(current_user.id, item.id)
    end

    stripe_session = Stripe::Checkout::Session.create({
                                                        customer: current_user.stripe_customer_id,
                                                        payment_method_types: ['card'],
                                                        line_items: stripe_line_items,
                                                        mode: 'payment',
                                                        success_url: "#{checkout_success_url}?session_id={CHECKOUT_SESSION_ID}",
                                                        cancel_url: checkout_cancel_url
                                                      })
    session.delete(:cart)
    redirect_to stripe_session.url, status: :see_other, allow_other_host: true
  end

  # TO DO rajouter les variables dans success.html.erb sinon virer la méthode
  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @customer = Stripe::Customer.retrieve(@session.customer)
  end

  def cancel; end

  private

  def stripe_line_items
    @cart.map do |item|
      ys = YogaSession.find(item.id)
      ys.to_stripe_format
    end
  end
end
