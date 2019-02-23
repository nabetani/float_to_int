def int_ceil?(x)
  x==x.ceil
end

def int_floor?(x)
  x==x.floor
end

def int_round?(x)
  x==x.round
end

def int_to_i?(x)
  x==x.to_i
end

def int_truncate?(x)
  x==x.truncate
end

def integer?(x)
  x==x.to_i
end

def is_int32_1(x)
  integer?(x) && (-2**31)<=x && x<=(2**31-1)
end

def is_int32_2(x)
  x==[x].pack('l').unpack1('l')[0]
end
