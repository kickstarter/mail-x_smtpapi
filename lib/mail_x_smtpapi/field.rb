require 'mail'
require_relative 'accessors'

module MailXSMTPAPI
  class Field < ::Mail::StructuredField
    FIELD_NAME = 'x-smtpapi'
    CAPITALIZED_FIELD = 'X-SMTPAPI'

    # Accessors
    include Recipients
    include Substitutions
    include UniqueArguments
    include Category
    include Filters

    def initialize(value = nil, charset = 'utf-8')
      super(FIELD_NAME, value || {}, charset)
    end

    # emits JSON with extra spaces inserted for line wrapping.
    def encoded
      if empty?
        ''
      else
        "#{CAPITALIZED_FIELD}: #{JSON.generate(value).gsub(/(["\]}])([,:])(["\[{])/, '\\1\\2 \\3')}\r\n"
      end
    end

    # the decoded version is good for interacting with the header in code
    # see: Mail::StructuredField#default
    def decoded
      value
    end

    def empty?
      value.values.all?{|v| !v || v.empty? }
    end
  end
end
