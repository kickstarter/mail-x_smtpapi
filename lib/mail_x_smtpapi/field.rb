require 'mail'
require 'json'
require_relative 'accessors'

module MailXSMTPAPI
  class Field < ::Mail::UnstructuredField
    FIELD_NAME = 'x-smtpapi'
    CAPITALIZED_FIELD = 'X-SMTPAPI'

    def self.singular? = true

    attr_reader :data

    # Accessors
    include Recipients
    include Substitutions
    include UniqueArguments
    include Category
    include AsmGroupId
    include Filters
    include Sections

    def initialize(value = nil, charset = 'utf-8')
      self.charset = charset
      self.name = CAPITALIZED_FIELD
      @data = value || {}
    end

    def value
      JSON.generate(data)
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
      value.gsub(/(["\]}])([,:])(["\[{])/, '\\1\\2 \\3')
    end

    def empty?
      data.values.all?{|v| !v || v.empty? }
    end
  end
end
