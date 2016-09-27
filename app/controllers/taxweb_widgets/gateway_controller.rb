require_dependency "taxweb_widgets/application_controller"
module TaxwebWidgets
  class GatewayController < ApplicationController

    def index
      @alerts = TaxwebWidgets::Alert.includes(:taxweb_widgets_users).where(taxweb_widgets_users: {user_id: nil}).where('taxweb_widgets_alerts.start <= :t AND taxweb_widgets_alerts.end >= :t', t: Time.now)
      render json: @alerts
    end

    def read
      record = TaxwebWidgets::User.find_or_create_by(taxweb_widgets_alert_id: params[:id], user_id: current_user.id)
      unless record
        render json: (record.errors rescue []), status: :unprocessable_entity
      end
      render json: record, status: :ok
    end

    def unread
      record = TaxwebWidgets::User.find_by(taxweb_widgets_alert_id: params[:id], user_id: current_user.id)
      record.destroy if record
      render nothing: true, status: :ok
    end

  end
end