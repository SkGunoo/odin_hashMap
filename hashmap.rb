class HashMap
  
  attr_reader :capcacity
  def initialize(capcacity, load_factor)
    @capcacity = capcacity
    @load_factor = load_factor
    @hash_map = Array.new(@capcacity) { [] }
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord}
    hash_code
  end

  def set(key,value)
    bucket_number = hash(key) % @capcacity
    insert_value_to_bucket(key,value,bucket_number)
    #testing if it works properly on terminal 
    # p @hash_map
    # puts 
    #check if hashmap's capacity need to be increased
    increase_capacity if more_entries_than_load_factor?
  end

  def more_entries_than_load_factor?
    load_factor = @capcacity * @load_factor
    load_factor <= self.length ? true : false
  end

  def increase_capacity
    @capcacity = @capcacity * 2
    #get all the entires so we can re distribute over increased sized hashmap
    key_value_pairs = self.entries
    #reset hashmap with increased capacity
    @hash_map = Array.new(@capcacity) {[]}
    #re distibute the key value pair over new hashmap
    key_value_pairs.each do |entry|
      bucket_number = hash(entry[0]) % @capcacity
      insert_value_to_bucket(entry[0],entry[1],bucket_number)
    end
  end

  def insert_value_to_bucket(key,value,bucket_number)
    #check if there is value with same key?
    overide = @hash_map[bucket_number].flatten.include?(key)
    
    if @hash_map[bucket_number].empty? || !overide
      @hash_map[bucket_number] << [key,value]
    else
      index_of_override = @hash_map[bucket_number].each_with_index do |el, index|
        break index if el.include?(key)
      end
      @hash_map[bucket_number][index_of_override][1] = value
    end
  end

  def get(key)
    bucket_number = hash(key) % @capcacity
    value = nil
    #retun nil if bucket is empty
    return value if @hash_map[bucket_number].empty?
    #raise error if bukcet_number is out of bound
    raise IndexError if bucket_number.negative? || bucket_number >= @hash_map.length
    @hash_map[bucket_number].each do |item|
      value = item[1] if item.include?(key)
    end
    value
  end

  def has?(key)
    key_exist = false
    #go through entire hashmap 
    @hash_map.each do |bucket|
      bucket.each do | item |
        #item[0] is key
        break key_exist = true if item[0] == key
      end
    end
    key_exist
  end

  def remove(key)
    bucket_number = hash(key) % @capcacity
    #this creates the reference to an element of @hash_map
    bucket = @hash_map[bucket_number]

    #get rid of item with reject! from bucket
    if pair = bucket.find {|item| item[0] == key }
      bucket.reject! {|item| item[0] == key}
      return pair[1]
    end
    nil
  end

  def length
    count = @hash_map.flatten.size / 2
    count
  end

  def clear
    @hash_map = Array.new(@capcacity) {[]}
    p @hash_map
  end

  def keys
    all_the_keys = []
    @hash_map.flatten.each_with_index do |el, index|
      #all the even? elements are keys in flattened hashmap
      all_the_keys << el if index.even?
    end
    all_the_keys
  end

  def values
    all_the_values = []
    @hash_map.flatten.each_with_index do |el, index|
      all_the_values << el if index.odd?
    end
    all_the_values
  end
  
  def entries
    all_the_key_value_pair = []
    flattened_hashmap = @hash_map.flatten
    #every 2 elements from flattened hashmap is key value pair
    flattened_hashmap.each_with_index do |el, index|
      all_the_key_value_pair << [el, flattened_hashmap[index + 1]] if index.even?
    end
    all_the_key_value_pair
  end

end


#test

# a = HashMap.new(16,0.75)

# a.set("a","haha")
# a.set("a","over")
# a.set("a","tata")
# a.set("hoho","popo")
# a.set("chch","papa")
# a.set("chch","ppa")
# a.set("chcrereh","papa")
# a.set("gtgtgt","papa")

# p a.get("a")
# p a.get("hoho")
# p a.has?("b")
# # p a.remove("a")
# puts a.length
# # a.clear
# p a.keys
# p a.values
# p a.entries
# 
test = HashMap.new(16,0.75)

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
# test.check_load_factor
test.set('power', 'golden')
p test.capcacity
p test.entries
puts test.get('power')