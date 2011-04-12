# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "achievable/version"

Gem::Specification.new do |s|
  s.name = "achievable"
  s.version = Achievable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Qi He"]
  s.email       = ["qihe229@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/achievable"
  s.summary     = %q{A simple achievment gem for rails.}
  s.description = %q{This provides achievement features for rails app.}

  s.rubyforge_project = "achievable"
  
  s.add_dependency  'sourcify'
  s.add_dependency  'resque'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
end