class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !self.include?(key)
      @store[key.hash % num_buckets] << key
      @count += 1
    end
    resize! if @count > num_buckets
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def remove(key)
    if self.include?(key)
      @store[key.hash % num_buckets].delete(key)
      @count -= 1
    end 
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_set = HashSet.new(num_buckets * 2)

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
