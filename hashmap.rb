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