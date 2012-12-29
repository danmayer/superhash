class SuperHash < Hash

  def initialize(*args, &context)
    if args && args.first.is_a?(Array) && context
      super()
      hash = SuperHash.from_array(args.first, &context)
      hash.each_pair{|key, value| self[key]=  value}
    else
      super()
    end
  end

  def self.from_array(array, &context)
    raise "requires context" if context.nil?
    array.flatten.inject(SuperHash.new){|h, val| h.update({val => (eval(val.to_s, context))}) }
  end

end

a = 3
b = 'wow'
c = 'crazy'

my_hash = SuperHash.from_array([:a, :b, :c]){}
puts my_hash.class
puts my_hash.inspect

# raises as it should
#my_hash = SuperHash.from_array([:a, :b, :c])
#puts my_hash.class
#puts my_hash.inspect

my_hash = SuperHash.new([:a, :b, :c]){}
puts my_hash.class
puts my_hash.inspect

my_hash = SuperHash.new([:a, :b, :c])
puts my_hash.class
puts my_hash.inspect

my_hash = SuperHash.new()
puts my_hash.class
puts my_hash.inspect

# class Binding
#   def map *vars
#     vars.flatten.compact.inject({}){|h,v| h.update v => eval(v.to_s, self)}
#   end
#   alias_method '>', 'map'
# end

# a = 4
# b = 2
# c = 42

# p binding > [:a, :b, :c]
# p binding > :a
# p binding > [:a,:c]


# class Symbol
#   def to_h(&block)
#     Hash[to_sym, block && (block.call || eval(to_s, block))]
#   end
# end

# class Array
#   def to_h(&block)
#     flatten.inject({}){|h, v| h.update(v.to_h(&block))}
#   end
# end

# a = 4
# b = 2
# c = 42

# p [:a, :b, :c].to_h{}

