class MaxIntSet
  attr_reader :store

  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if num >= @store.length || num < 0
    @store[num] = true
  end

  def remove(num)
    raise "Out of bounds" if num >= @store.length || num < 0
    @store[num] = false
  end

  def include?(num)
    raise "Out of bounds" if num >= @store.length || num < 0
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] << num if !self.include?(num)
  end

  def remove(num)
    @store[num % num_buckets].delete(num) if self.include?(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !self.include?(num)
      @store[num % num_buckets] << num
      @count += 1
    end
    resize! if @count > num_buckets
  end

  def remove(num)
    if self.include?(num)
      @store[num % num_buckets].delete(num)
      @count -= 1
    end 
  end

  def include?(num)
    @store[num % num_buckets].include?(num)

  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_set = ResizingIntSet.new(num_buckets * 2)

    @store.each do |ele| 
      if ele.is_a?(Array)
        ele.each {|i| new_set.insert(i)}
      else 
        new_set.insert(ele)
      end
    end
    @store = new_set.store
  end
end
