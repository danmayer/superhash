class SuperHash < Hash

  def initialize(array, &context)
    hash = SuperHash.from_array(array, &context)
    super()
    hash.each_pair{|key, value| self[key]=  value}
  end

  def self.from_array(array, &context)
    array.flatten.inject({}){|h, val| h.update({val => (eval(val.to_s, context))}) }
  end

end

a = 3
b = 'wow'
c = 'crazy'

# puts SuperHash.new([:a, :b, :c])
my_hash = SuperHash.from_array([:a, :b, :c]){}
puts my_hash.class
puts my_hash.inspect

my_hash = SuperHash.new([:a, :b, :c]){}
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

