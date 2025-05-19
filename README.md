# Mail::X::Smtpapi

[![Gem Version](https://badge.fury.io/rb/mail-x_smtpapi-ksr.svg)](http://badge.fury.io/rb/mail-x_smtpapi-ksr)

Integrates support for SendGrid's X-SMTPAPI field into the [Mail](https://github.com/mikel/mail) gem.

Please refer to [SendGrid docs](https://sendgrid.com/docs/API_Reference/SMTP_API/index.html) for ideas of what you can do with the X-SMTPAPI header!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mail-x_smtpapi-ksr'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mail-x_smtpapi-ksr

## Usage

Write into the X-SMTPAPI header from anywhere with access to the `mail` object.

### Example: Rails Mailer

Adapting the [Rails Guide example](http://guides.rubyonrails.org/v4.0.8/action_mailer_basics.html#edit-the-mailer):

```ruby
class UserMailer < ActionMailer::Base

  def welcome(user)
    @user = user

    mail.smtpapi.category = 'welcome'
    mail.smtpapi.unique_args['user_id'] = @user.id

    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end
```

### Example: Mail Interceptor

Adapting the [Rails Guide example](http://guides.rubyonrails.org/v4.0.8/action_mailer_basics.html#intercepting-emails):

```ruby
class SandboxEmailInterceptor
  def self.delivering_email(message)
    message.smtpapi.unique_args['original'] = message.to
    message.to = ['sandbox@example.com']
  end
end
```

### Example: Template Helper

```ruby
module MailerABHelper
  def show_variant?(name)
    variant = rand(2) == 0 ? 'main' : 'alternate'
    mail.smtpapi.unique_args["#{name}_variant"] = variant
    return variant == 'alternate'
  end
end
```

## Contributing

1. Fork it ( https://github.com/kickstarter/mail-x_smtpapi/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
