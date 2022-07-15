# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :initialize_session_cart
  before_action :load_cart

  private

  def initialize_session_cart
    session[:cart] ||= []
  end

  def load_cart
    return if session[:cart].empty?

    @cart = YogaSession.find(session[:cart])
  end
end
