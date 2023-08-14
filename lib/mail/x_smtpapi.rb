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
  Mail::Field::FIELDS_MAP[name]     = MailXSMTPAPI::Field
  Mail::Field::FIELD_NAME_MAP[name] = MailXSMTPAPI::Field::CAPITALIZED_FIELD
end
