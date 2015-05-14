require 'multy/version'

module Multy
  def build_multi_method(name, *args, &block)
    raise 'invalid arguments number' unless args.size == block.arity
    name2 = fn_name(*args)
    meths[name] = {} if meths[name].nil?
    meths[name][name2] = block
  end

  def mcall(name, *args)
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
