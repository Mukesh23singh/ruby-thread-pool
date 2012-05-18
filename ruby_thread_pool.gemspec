# -*- coding: utf-8 -*-
#require File.expand_path('../lib/db_config', __FILE__)

Gem::Specification.new do |s|

  s.name = 'ruby_thread_pool'
  s.version = "0.1.0"
  s.author = 'Jürgen Bickert'
  s.homepage = 'http://juergenbickert.de'
  s.email = 'juergenbickert@gmail.com'

  s.summary = "A thread pool library for ruby."
  s.description = "You can easily run number limited threads in parallel with ruby."

  s.files = Dir.glob("{bin,lib,spec,features}/**/*")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.bindir = "bin"
  s.require_paths << "lib"
end
