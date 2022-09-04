# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    # docs: https://stripe.com/docs/payments/checkout/fulfill-orders
    # receive POST from Stripe
    payload = request.body.read
    signature_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = ENV.fetch('STRIPE_WEBHOOK_SECRET')
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, signature_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      # Invalid payload
      render json: { message: e }, status: :bad_request
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      render json: { message: e }, status: :bad_request
      return
    end

    if event['type'] == 'checkout.session.completed'
      checkout_session = event['data']['object']
      create_booking(checkout_session, event)
    end

    head :ok
  end

  private

  def create_booking(checkout_session, event)
    user = User.find_by(stripe_customer_id: checkout_session.customer)

    session = event.data.object
    session_with_expand = Stripe::Checkout::Session.retrieve({ id: session.id, expand: ['line_items'] })
    session_with_expand.line_items.data.each do |line_item|
      ys = YogaSession.find_by(stripe_yoga_session_id: line_item.price.product)
      Booking.create(yoga_session: ys, user: user)
    end
  end
end
