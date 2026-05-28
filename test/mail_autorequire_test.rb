require_relative 'test_helper'
require 'open3'

class MailAutorequireTest < Minitest::Test
  PROJECT_ROOT = File.expand_path('..', __dir__)

  def test_bundler_default_require_loads_smtpapi_extension
    script = <<~RUBY
      require 'bundler'
      Bundler.require(:default)
      require 'mail'
      puts Mail.new.respond_to?(:smtpapi)
    RUBY

    out, err, status = run_bundle_ruby(script)

    assert status.success?, "Expected script to succeed, got:\n#{err}"
    assert_equal 'true', out.chomp
  end

  def test_hyphenated_gem_name_is_requireable
    script = <<~RUBY
      require 'mail-x_smtpapi-ksr'
      require 'mail'
      puts Mail.new.respond_to?(:smtpapi)
    RUBY

    out, err, status = run_bundle_ruby(script)

    assert status.success?, "Expected script to succeed, got:\n#{err}"
    assert_equal 'true', out.chomp
  end

  def test_slash_form_is_requireable
    script = <<~RUBY
      require 'mail/x_smtpapi/ksr'
      require 'mail'
      puts Mail.new.respond_to?(:smtpapi)
    RUBY

    out, err, status = run_bundle_ruby(script)

    assert status.success?, "Expected script to succeed, got:\n#{err}"
    assert_equal 'true', out.chomp
  end

  private

  def run_bundle_ruby(script)
    Bundler.with_unbundled_env do
      Open3.capture3('bundle', 'exec', 'ruby', '-e', script, chdir: PROJECT_ROOT)
    end
  end
end
