require 'rails/generators/base'

module TaxwebWidgets
  class ViewGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../../app/views/taxweb_widgets", __FILE__)

    def copy_views
      directory 'widgets', 'app/views/taxweb_widgets/widgets'
    end
  end
end