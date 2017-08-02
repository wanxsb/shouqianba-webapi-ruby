# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shouqianba/webapi/version'

Gem::Specification.new do |spec|
  spec.name          = "shouqianba-webapi-ruby"
  spec.version       = Shouqianba::Webapi::VERSION
  spec.authors       = ["wanxsb@gmail.com"]
  spec.email         = ["wanxsb@gmail.com"]

  spec.summary       = "收钱吧Webapi接口"
  spec.description   = "收钱吧Webapi接口"
  spec.homepage      = "http://www.diandanbao.com"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "settingslogic"
end
