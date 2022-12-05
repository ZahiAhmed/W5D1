require "byebug"
class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    
    self.join.to_i.hash
  end
end

class String
  def hash
    array = []
    self.each_char{|char| array << char.ord}
    array.join.to_i.hash
  end

end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    array = []
    self.each{|k,v| array << k.to_s.ord << v.to_s.ord}
    array.sort.join.to_i.hash
  end
end
