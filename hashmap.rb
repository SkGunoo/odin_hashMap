class HashMap
  
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
    p @hash_map
    puts 
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

end


#test

a = HashMap.new(16,0.75)

a.set("a","haha")
a.set("a","over")
a.set("a","tata")
a.set("hoho","popo")
a.set("chch","papa")
a.set("chch","ppa")
a.set("chcrereh","papa")
p a.get("a")
p a.get("hoho")
p a.has?("b")
p a.remove("a")
