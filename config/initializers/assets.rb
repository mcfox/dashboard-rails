

Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|woff2|ttf)\z/

Rails.application.config.assets.precompile += %w( taxweb_widgets.js taxweb_widgets.css  )