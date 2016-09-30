module TaxwebWidgets
  class User < ActiveRecord::Base

    self.table_name = :taxweb_widgets_users

    belongs_to :user

    validates :widget, :action, presence: true
  end
end