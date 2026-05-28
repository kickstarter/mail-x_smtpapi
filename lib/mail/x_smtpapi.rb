require_relative '../mail_x_smtpapi/field'
require 'mail'

module Mail
  class Message
    def smtpapi
      header.smtpapi
    end
  end

  class Header
    def smtpapi
      name = MailXSMTPAPI::Field::FIELD_NAME
      self.fields << Field.new(name) unless self[name]
      self[name]
    end
  end
end

MailXSMTPAPI::Field::FIELD_NAME.tap do |name|
  Mail::Field::FIELDS_MAP[name]     = Gem::Version.new(Mail::VERSION::STRING) >= Gem::Version.new('2.9.0') ? MailXSMTPAPI::Field.to_s : MailXSMTPAPI::Field
  Mail::Field::FIELD_NAME_MAP[name] = MailXSMTPAPI::Field::CAPITALIZED_FIELD
end
