require 'rails/generators/base'

module DashboardRails
  class ViewGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../../app/views/dashboard-rails", __FILE__)

    def copy_views
      directory 'widgets', 'app/views/dashboard-rails/widgets'
    end
  end
end