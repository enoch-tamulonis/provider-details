class ModalController < ApplicationController
  def create
    render turbo_stream: append_turbo_modal(params[:frame], params[:url])
  end
end
