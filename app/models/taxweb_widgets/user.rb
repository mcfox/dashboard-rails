module TaxwebWidgets
  class User < ActiveRecord::Base

    self.table_name = :taxweb_widgets_users

    belongs_to :user
    belongs_to :taxweb_widgets_alert, class_name: "TaxwebWidgets::Alert", foreign_key: 'taxweb_widgets_alert_id'

    validates :user_id, :taxweb_widgets_alert_id, presence: true
  end
end