# frozen_string_literal: true

require File.expand_path('../lib/singer_heroku/version', __FILE__)

Gem::Specification.new do |s|
  s.name         = 'singer-heroku'
  s.version      = SingerHeroku::VERSION
  s.platform     = Gem::Platform::RUBY
  s.date         = '2017-06-21'
  s.summary      = 'Singer.io utilities for executing on Heroku'
  s.description  = <<-eos
    Creates config files from ENV; Read/writes state from postgres database
  eos
  s.authors      = ['Joe Lind']
  s.email        = 'joelind@gmail.com'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/Follain/singer-heroku'

  s.files        = Dir['{lib}/**/*.rb', 'bin/*', 'LICENSE', '*.md']
  s.require_path = 'lib'
  s.executables  = %w[generate-config read-state write-state]
  s.add_runtime_dependency 'pg'
  s.add_runtime_dependency 'rake'
  s.add_runtime_dependency 'sequel','~>5.31.0'
end
