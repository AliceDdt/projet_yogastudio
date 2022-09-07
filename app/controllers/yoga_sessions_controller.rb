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
        format.html { redirect_to yoga_sessions_path, alert: I18n.t('yoga_sessions.already_added_to_cart') }
        format.turbo_stream { flash.now[:alert] = I18n.t('yoga_sessions.already_added_to_cart') }
      end
    else
      @session = session[:cart] << id
      respond_to do |format|
        format.html { redirect_to yoga_sessions_path, notice: I18n.t('yoga_sessions.added_to_cart') }
        format.turbo_stream { flash.now[:notice] = I18n.t('yoga_sessions.added_to_cart') }
      end
    end
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to cart_index_path
  end
end
