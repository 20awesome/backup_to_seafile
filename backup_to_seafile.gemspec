# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'backup_to_seafile/version'

Gem::Specification.new do |spec|
  spec.name          = "backup_to_seafile"
  spec.version       = BackupToSeafile::VERSION
  spec.authors       = ["vladyslav.bolibruk"]
  spec.email         = ["vladyslav.bolibruk@masterofcode.com"]

  spec.summary       = %q{backup_to_seafile gem for backup files to seafile server}
  spec.description   = %q{gem for backup files to seafile server}
  spec.homepage      = "https://github.com/20awesome/backup_to_seafile"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  #spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files       = ["lib/SeafileBackup.rb", "lib/create_config.rake" ,"lib/accountinfo.yml"]
  spec.bindir        = "exe"
  spec.executables   = %w(backup_to_seafile)
  spec.require_paths = ["lib"]


  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 0'
end
