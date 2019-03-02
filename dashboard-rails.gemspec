$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dashboard-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "dashboard-rails"
  spec.version     = DashboardRails::VERSION
  spec.authors     = ["TaxWeb"]
  spec.email       = ["produto@taxweb.com.br"]
  spec.homepage    = "http://www.taxweb.com.br"
  spec.summary     = "Gerenciamento de Widgets para Dashboard"
  spec.description = "Gerenciamento de Widgets para Dashboard"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  # spec.test_files = Dir["spec/**/*"]

  spec.add_dependency 'rails', ['>= 3','< 5']

  # spec.add_runtime_dependency 'spreadsheet'
  # spec.add_runtime_dependency 'to_xls'

  # spec.add_development_dependency 'rspec'

end
