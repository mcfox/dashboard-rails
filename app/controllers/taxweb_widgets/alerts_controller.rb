require_dependency "taxweb_widgets/application_controller"

module TaxwebWidgets
  class AlertsController < ApplicationController

    before_action :set_alert, only: [:show, :edit, :update, :destroy]

    def user
      @alerts = TaxwebWidgets::Alert.joins(:taxweb_widgets_users).where(taxweb_widgets_users: {user_id: current_user.id}).order(:start)
    end

    # GET /alerts
    def index
      @alerts = TaxwebWidgets::Alert.order(:start)
    end

    # GET /alerts/1
    def show
    end

    # GET /alerts/new
    def new
      @alert = TaxwebWidgets::Alert.new
    end

    # GET /alerts/1/edit
    def edit
    end

    # POST /alerts
    def create
      @alert = TaxwebWidgets::Alert.new(alert_params)

      if @alert.save
        redirect_to taxweb_widgets_alerts_path, notice: 'Alerta criado.'
      else
        render :new
      end
    end

    # PATCH/PUT /alerts/1
    def update
      if @alert.update(alert_params)
        redirect_to taxweb_widgets_alerts_path, notice: 'Alerta atualizado.'
      else
        render :edit
      end
    end

    # DELETE /alerts/1
    def destroy
      @alert.destroy
      redirect_to taxweb_widgets_alerts_path, notice: 'Alerta removido.'
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert
      @alert = TaxwebWidgets::Alert.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def alert_params
      params.require(:taxweb_widgets_alert).permit(:id, :mtype, :message, :timeout, :start, :end)
    end

  end
end