lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spree_shipping_matrix/version'

Gem::Specification.new do |s|
  s.name        = 'spree_shipping_matrix'
  s.version     = SpreeShippingMatrix::VERSION

  s.summary     = 'Advanced shipping calculator based on rules matrix for Spree'
  s.description = ''

  s.homepage  = 'https://github.com/madebymade/spree_shipping_matrix'

  s.authors = ['Luke Morton']
  s.email   = ['luke@madebymade.co.uk']

  s.license = 'MIT'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.require_path = 'lib'
  s.requirements << 'none'

  s.platform    = Gem::Platform::RUBY

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'spree_core', '2.4.0.beta'

  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'sass-rails', '~> 4.0.2'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'tailor'
  s.add_development_dependency 'codeclimate-test-reporter'
end
