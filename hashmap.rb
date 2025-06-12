class HashMap

  def initialize(capcacity, load_factor)
    @capcacity = capcacity
    @load_factor = load_factor
    @hash_map = Array.new(@capcacity,[]) 
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord}
    hash_code
  end

 
end

