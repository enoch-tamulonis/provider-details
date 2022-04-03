class ProvidersController < ApplicationController
  include ActionView::RecordIdentifier
  def new; end

  def create
    @provider = Provider.find_by_npi_number(params[:npi_number])
    @provider ||= Provider.create_from_npi(params[:npi_number])
    if @provider.update(updated_at: Time.zone.now)
      render turbo_stream: [append_turbo_modal(dom_id(@provider), provider_path(@provider)),
        turbo_stream.update("new_provider", partial: "form")]
    else
      render turbo_stream: turbo_stream.append("alerts", partial: "layouts/alert", locals: { alert: @provider.errors.full_messages.first })
    end
  end

  def index
    @providers = Provider.all.order(updated_at: :desc)
  end

  def show
    @provider = Provider.find(params[:id])
  end
end
