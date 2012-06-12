# -*- encoding: utf-8 -*-
require File.expand_path('../lib/guard/frank/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alex Denisov"]
  gem.email         = ["1101.debian@gmail.com"]
  gem.description   = %q{Guard::Frank automatically run frank-cucumber features for iOS }
  gem.summary       = %q{Guard gem for frank-cucumber}
  gem.homepage      = "https://github.com/AlexDenisov/guard-frank"
  gem.files         = Dir.glob('{lib}/**/*') + %w[LICENSE README.md]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "guard-frank"
  gem.require_paths = ["lib"]
  gem.version       = Guard::FrankVersion::VERSION
  gem.add_dependency 'guard', '>=1.1.1'
  gem.add_dependency 'frank-cucumber'
  gem.required_ruby_version     = '>= 1.8.7'
  gem.required_rubygems_version = '>= 1.3.6'
  gem.post_install_message = %{
    See https://github.com/AlexDenisov/guard-frank#readme for more details
  }
end
