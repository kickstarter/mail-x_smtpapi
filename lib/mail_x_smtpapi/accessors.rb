module MailXSMTPAPI

  module Recipients
    def to
      data['to'] ||= []
    end

    def to=(val)
      val = [val] unless val.is_a? Array
      to.replace val
    end
  end

  module Substitutions
    def substitutions
      data['sub'] ||= {}
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
      data['unique_args'] ||= {}
    end

    def unique_args=(val)
      raise ArgumentError unless val.is_a? Hash
      unique_args.replace(val)
    end
  end

  module Category
    def category
      data['category']
    end

    def category=(val)
      data['category'] = val
    end
  end

  module AsmGroupId
    def asm_group_id
      data['asm_group_id']
    end

    def asm_group_id=(val)
      data['asm_group_id'] = val
    end
  end

  module Filters
    def filters
      data['filters'] ||= {}
    end
  end

  module Sections
    def sections
      data['section'] ||= {}
    end
  end

end
