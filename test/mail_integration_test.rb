require_relative 'test_helper'

class MailIntegrationTest < MiniTest::Unit::TestCase

  def test_smtpapi_accessor
    assert subject.smtpapi
    assert subject.smtpapi.empty?

    subject.smtpapi.value['to'] = 'c@example.com'
    refute subject.smtpapi.empty?

    assert_equal 'c@example.com', subject.smtpapi.value['to']
  end

  def test_hash_reader
    assert_equal subject.smtpapi, subject['x-smtpapi']
    assert_equal subject.smtpapi, subject['X_SMTPAPI']
  end

  def test_hash_writer
    subject['x-smtpapi'] = {'to' => 'c@example.com'}
    assert_equal 'c@example.com', subject.smtpapi.value['to']
  end

  def test_limited_field
    subject['x-smtpapi'] = {'to' => 'c@example.com'}
    subject['x-smtpapi'] = {'to' => 'd@example.com'}

    refute subject['x-smtpapi'].is_a?(Array)
    assert_equal 'd@example.com', subject['x-smtpapi'].value['to']
  end

  def test_field_name
    assert_equal 'X-SMTPAPI', subject.smtpapi.name
  end

  private

  def subject
    @subject ||= ::Mail.new do
      to 'a@example.com'
      reply_to 'b@example.com'
      date Time.now
    end
  end

end
