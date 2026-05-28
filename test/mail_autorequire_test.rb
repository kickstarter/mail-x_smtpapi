require_relative 'test_helper'
require 'open3'

class MailAutorequireTest < Minitest::Test
  PROJECT_ROOT = File.expand_path('..', __dir__)

  def test_bundler_default_require_loads_smtpapi_extension
    out, err, status = run_bundle_ruby('require "bundler"; Bundler.require(:default); require "mail"; puts Mail.new.respond_to?(:smtpapi)')

    assert status.success?, "Expected script to succeed, got:\n#{err}"
    assert_equal "true\n", out
  end

  def test_hyphenated_gem_name_is_requireable
    out, err, status = run_bundle_ruby('require "mail-x_smtpapi-ksr"; require "mail"; puts Mail.new.respond_to?(:smtpapi)')

    assert status.success?, "Expected script to succeed, got:\n#{err}"
    assert_equal "true\n", out
  end

  def test_slash_form_is_requireable
    out, err, status = run_bundle_ruby('require "mail/x_smtpapi/ksr"; require "mail"; puts Mail.new.respond_to?(:smtpapi)')

    assert status.success?, "Expected script to succeed, got:\n#{err}"
    assert_equal "true\n", out
  end

  private

  def run_bundle_ruby(script)
    Bundler.with_unbundled_env do
      Open3.capture3('bundle', 'exec', 'ruby', '-e', script, chdir: PROJECT_ROOT)
    end
  end
end
