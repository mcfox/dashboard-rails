module TaxwebWidgets
  class Alert < ActiveRecord::Base

    self.table_name = :taxweb_widgets_alerts

    has_many :taxweb_widgets_users, dependent: :destroy, class_name: "TaxwebWidgets::User", foreign_key: 'taxweb_widgets_alert_id'

    validates :mtype, :message, :timeout, :start, :end, presence: true

  end
end