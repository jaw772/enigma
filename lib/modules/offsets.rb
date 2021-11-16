module Offsets
  def create_offset(date)
    offset_hash = {}
    main = date.to_i**2
    main = main.to_s
    main = main.chars
    offset_hash["a"] = main[-4].to_i
    offset_hash["b"] = main[-3].to_i
    offset_hash["c"] = main[-2].to_i
    offset_hash["d"] = main[-1].to_i
    offset_hash
  end
end
