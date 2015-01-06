module MailXSMTPAPI

  module Recipients
    def to
      value['to'] ||= []
    end

    def to=(val)
      val = [val] unless val.is_a? Array
      to.replace val
    end
  end

  module Substitutions
    def substitutions
      value['sub'] ||= {}
    end

    def substitutions=(val)
      raise ArgumentError unless val.is_a? Hash
      substitutions.replace(val)
    end

    def merge_substitutions(name, val)
      substitutions[name] ||= []
      val = [val] unless val.is_a? Array
      substitutions[name].concat val.map(&:to_s)
    end
  end

  module UniqueArguments
    def unique_args
      value['unique_args'] ||= {}
    end

    def unique_args=(val)
      raise ArgumentError unless val.is_a? Hash
      unique_args.replace(val)
    end
  end

  module Category
    def category
      value['category']
    end

    def category=(val)
      value['category'] = val
    end
  end

  module Filters
    def filters
      value['filters'] ||= {}
    end
  end

  module Sections
    def sections
      value['section'] ||= {}
    end
  end

end
