module TaxwebWidgets
  class Engine < ::Rails::Engine
    # isolate_namespace TaxwebWidgets #ENGINE


    # config.autoload_paths << Rails.root.join('app','widgets')
    config.autoload_paths << File.expand_path("../app/widgets", __FILE__)
  end
end
