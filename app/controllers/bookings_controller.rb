# frozen_string_literal: true

class BookingsController < ApplicationController
  before_action :require_login

  def create
    # to do if not created error msg
    @cart.each do |item|
      Booking.create!(yoga_session: item, user: current_user)
    end

    stripe_session = Stripe::Checkout::Session.create({
                                                        customer: current_user.stripe_customer_id,
                                                        payment_method_types: ['card'],
                                                        line_items: stripe_line_items,
                                                        mode: 'payment',
                                                        success_url: "#{checkout_success_url}?session_id={CHECKOUT_SESSION_ID}",
                                                        cancel_url: checkout_cancel_url
                                                      })

    redirect_to stripe_session.url, status: :see_other, allow_other_host: true
  end

  private

  # TO DO rajouter les variables dans success.html.erb sinon virer la méthode
  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @customer = Stripe::Customer.retrieve(session.customer)
  end

  # to do : gérer le cas d'échec du paiement :

  def stripe_line_items
    @cart.map do |item|
      ys = YogaSession.find(item.id)
      ys = ys.to_stripe_format
    end
  end
end
