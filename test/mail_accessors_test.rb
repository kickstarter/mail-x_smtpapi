require_relative 'test_helper'

class MailXSMTPAPI::AccessorsTest < MiniTest::Unit::TestCase

  def test_to
    subject.to = 'a@example.com'
    assert_equal ['a@example.com'], subject.to
    subject.to << 'b@example.com'
    assert_equal ['a@example.com', 'b@example.com'], subject.to
  end

  def test_substitutions
    subject.substitutions['foo'] = ['bar']
    assert_equal ['bar'], subject.substitutions['foo']

    subject.merge_substitutions('foo', ['baz', 'qux'])
    assert_equal ['bar', 'baz', 'qux'], subject.substitutions['foo']
  end

  def test_unique_args
    subject.unique_args['foo'] = 'bar'
    assert_equal 'bar', subject.unique_args['foo']

    subject.unique_args = {'hello' => 'world'}
    refute subject.unique_args['foo']
    assert_equal 'world', subject.unique_args['hello']
  end

  def test_category
    subject.category = 'password_reset'
    assert_equal 'password_reset', subject.category
  end

  private

  def subject
    @subject ||= MailXSMTPAPI::Field.new
  end
end
