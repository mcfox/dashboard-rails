module DashboardRails
  class Engine < ::Rails::Engine
    # config.eager_load_paths << DashboardRails::Engine.root.join('app','widgets')
    config.autoload_paths << DashboardRails::Engine.root.join('app','widgets')
  end
end
