# frozen_string_literal: true

class YogaSessionsController < ApplicationController
  def index
    @yoga_sessions = YogaSession.all.order(start_date: :asc, created_at: :asc)
  end

  def add_to_cart #TO DO rajouter message d'erreur
    @yoga_session = YogaSession.find(params[:id])
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)

    respond_to do |format|
      format.html { redirect_to yoga_sessions_path, notice: "Quote was successfully created." }
      # format.turbo_stream { turbo_stream.replace(dom_id(@yoga_session)) }
      format.turbo_stream { flash.now[:notice] = 'Quote was successfully created.' }
    end
  end

  def remove_from_cart #TO DO rajouter msg d'info
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to cart_index_path
  end
end
