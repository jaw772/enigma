module Keys

  def create_keys(key)
    key_array = key.chars
    key_hash = {}
    key_hash["a"] = (key_array[0].concat(key_array[1])).to_i
    key_hash["b"] = (key_array[1].concat(key_array[2])).to_i
    key_hash["c"] = (key_array[2].concat(key_array[3])).to_i
    key_hash["d"] = (key_array[3].concat(key_array[4])).to_i
    key_hash
  end
end
