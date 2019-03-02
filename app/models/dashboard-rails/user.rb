module DashboardRails
  class User < ActiveRecord::Base

    self.table_name = :dashboard_settings
    belongs_to :user
    validates :widget, :action, presence: true

  end
end