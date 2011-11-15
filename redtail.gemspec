# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'redtail/version'

Gem::Specification.new do |s|
  s.name        = 'redtail'
  s.version     = Redtail::VERSION
  s.authors     = ['blahed']
  s.email       = ['tdunn13@gmail.com']
  s.homepage    = ''
  s.summary     = 'Ruby client for the django-sentry project'
  s.description = 'Ruby client for the django-sentry project'

  s.rubyforge_project = 'redtail'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  
  s.add_dependency 'json_pure'
  s.add_dependency 'uuid'

  s.add_development_dependency 'minitest'

end
