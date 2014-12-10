require_relative 'test_helper'

class MailXSMTPAPI::FieldTest < MiniTest::Unit::TestCase
  def test_encoded_with_blank_values
    assert_equal '', subject.new.encoded
  end

  def test_encoded_has_field_name
    f = subject.new({'to' => ['a@example.com', 'b@example.com']})
    assert f.encoded.match(/^X-SMTPAPI: /), f.encoded
  end

  def test_encoded_has_spaces_in_json
    f = subject.new({'to' => ['a@example.com', 'b@example.com']})
    assert f.encoded.include?('{"to": ["a@example.com", "b@example.com"]}')
  end

  def test_encoded_ends_with_crlf
    f = subject.new({'to' => ['a@example.com', 'b@example.com']})
    assert f.encoded.match(/\r\n$/)
  end

  def test_encoded_is_folded
    f = subject.new('to' => 100.times.map{ 'test@example.com'} )
    max_line_length = f.encoded.split(/[\r\n]+/).map(&:length).max
    assert max_line_length < 998, "max line length: #{max_line_length}"
  end

  def test_decoded
    h = {'to' => ['a@example.com', 'b@example.com']}
    assert_equal '{"to": ["a@example.com", "b@example.com"]}', subject.new(h).decoded
  end

  def test_empty?
    refute subject.new({'to' => ['a@example.com']}).empty?
    assert subject.new({'to' => []}).empty?
  end

  private

  def subject
    MailXSMTPAPI::Field
  end
end
