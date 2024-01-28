# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mail_x_smtpapi/version'

Gem::Specification.new do |spec|
  spec.name          = "mail-x_smtpapi"
  spec.version       = MailXSMTPAPI::VERSION
  spec.authors       = ["Lance Ivy"]
  spec.email         = ["lance@kickstarter.com"]
  spec.summary       = %q{Adds SendGrid X-SMTPAPI header support to Mail}
  spec.homepage      = "https://github.com/kickstarter/mail-x_smtpapi"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2.2.3"
  spec.add_development_dependency "rake", "~> 13.1"
  spec.add_development_dependency "minitest", "~> 5.21"

  spec.add_dependency "mail", "~> 2.7.1"
  spec.add_dependency "net-smtp"
end
