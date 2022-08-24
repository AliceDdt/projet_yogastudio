# frozen_string_literal: true

class YogaSessionsController < ApplicationController
  def index
    @yoga_sessions = YogaSession.where('start_date >= NOW()')
                                .order(start_date: :asc, created_at: :asc)
  end

  def add_to_cart
    @yoga_session = YogaSession.find(params[:id])
    id = params[:id].to_i

    if session[:cart].include?(id)
      respond_to do |format|
        format.html { redirect_to yoga_sessions_path, notice: 'Yoga session was already added to cart.' }
        format.turbo_stream { flash.now[:notice] = 'Yoga session was already added to cart.' }
      end
    else
      @session = session[:cart] << id
      respond_to do |format|
        format.html { redirect_to yoga_sessions_path, notice: 'Yoga session was added to cart.' }
        format.turbo_stream { flash.now[:notice] = 'Yoga session was added to cart.' }
      end
    end
  end

  def remove_from_cart # TO DO rajouter msg d'info
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to cart_index_path
  end
end
