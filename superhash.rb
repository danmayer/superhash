class SuperHash < Hash

  def initialize(*args, &context)
    if args && args.first.is_a?(Array) && context
      super()
      hash = SuperHash.from_array(args.first, &context)
      hash.each_pair{|key, value| self[key]=  value}
    elsif args && args.first.is_a?(Array) && context.nil?
      raise "requires context block for binding"
    else
      super()
    end
  end

  def self.from_array(array, &context)
    raise "requires context block for binding" if context.nil?
    array.flatten.inject(SuperHash.new){|h, val| h.update({val => (eval(val.to_s, context))}) }
  end

end

calculation = 7
word        = "a word"
data        = "more data"

my_hash = SuperHash.from_array([:calculation, :word, :data]){}
puts my_hash.class
puts my_hash.inspect

my_hash = SuperHash.new([:calculation, :word, :data]){}
puts my_hash.class
puts my_hash.inspect

begin
  my_hash = SuperHash.new([:calculation, :word, :data])
  puts my_hash.class
  puts my_hash.inspect
rescue => err
  puts err
end

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

