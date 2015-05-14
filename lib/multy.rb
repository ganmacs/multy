require 'multy/version'

module Multy
  def define_multi_method(name, *types, &block)
    raise 'invalid arguments number' unless types.size == block.arity
    name = "_#{name}"

    def_double_disptch(name)
    type_name = join_type(*types)

    _methods[name] = {} if _methods[name].nil?
    _methods[name][type_name] = block
  end

  def def_double_disptch(name)
    Multy.module_eval <<-EOS
      def #{name}(*args)
        kls_name = args.map(&:class).map(&:to_s).join('_')

        if _methods["#{name}"] && _methods["#{name}"][kls_name]
          _methods["#{name}"][kls_name].call(*args)
        else
          raise "Not found #{name} method"
        end
      end
      alias_method :#{name[1..-1]}, :#{name}
    EOS
  end

  def join_type(*args)
    args.map(&:to_s).join('_')
  end

  def _methods
    @_methods ||= {}
  end
end
