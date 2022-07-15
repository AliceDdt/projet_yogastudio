# frozen_string_literal: true

class YogaSessionsController < ApplicationController
  def index
    @yoga_sessions = YogaSession.all.order(start_date: :asc, created_at: :asc)
  end

  def add_to_cart #TO DO rajouter message d'erreur
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to yoga_sessions_path
  end

  def remove_from_cart #TO DO rajouter msg d'info
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to cart_index_path
  end
end
