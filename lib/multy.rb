require 'multy/version'

module Multy
  def define_multi_method(name, *args, &block)
    raise 'invalid arguments number' unless args.size == block.arity
    name = "_#{name}"

    def_double_disptch(name)

    meths[name] = {} if meths[name].nil?
    meths[name][fn_name(*args)] = block
  end

  def def_double_disptch(name)
    Multy.module_eval <<-EOS
      def #{name}(*args)
        kls_name = args.map(&:class).map(&:to_s).join('_')

        raise "Not found #{name} method and argument " if meths["#{name}"].nil?
        raise "Not found #{name} method and argument " if meths["#{name}"][kls_name].nil?
        meths["#{name}"][kls_name].call(*args)
      end
    EOS
  end

  def mcall(name, *args)
    name = "_#{name}"
    n = args.map(&:class).map(&:to_s).join('_')
    meths[name][n].call(*args)
  end

  def fn_name(*args)
    args.map(&:to_s).join('_')
  end

  def meths
    @meths ||= {}
  end
end
