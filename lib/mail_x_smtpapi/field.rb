require 'mail'
require_relative 'accessors'

module MailXSMTPAPI
  class Field < ::Mail::UnstructuredField
    FIELD_NAME = 'x-smtpapi'
    CAPITALIZED_FIELD = 'X-SMTPAPI'

    # Accessors
    include Recipients
    include Substitutions
    include UniqueArguments
    include Category
    include Filters
    include Sections

    def initialize(value = nil, charset = 'utf-8')
      self.charset = charset
      self.name = CAPITALIZED_FIELD
      self.value = value || {}
    end

    def encoded
      if empty?
        ''
      else
        "#{wrapped_value}\r\n"
      end
    end

    # to take advantage of folding, decoded must return a string of
    # JSON with extra spaces inserted for line wrapping.
    def decoded
      JSON.generate(value).gsub(/(["\]}])([,:])(["\[{])/, '\\1\\2 \\3')
    end

    def empty?
      value.values.all?{|v| !v || v.empty? }
    end
  end
end
