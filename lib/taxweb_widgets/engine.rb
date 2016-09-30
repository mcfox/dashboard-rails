module TaxwebWidgets
  class Engine < ::Rails::Engine
    # config.eager_load_paths << TaxwebWidgets::Engine.root.join('app','widgets')
    config.autoload_paths << TaxwebWidgets::Engine.root.join('app','widgets')
  end
end
