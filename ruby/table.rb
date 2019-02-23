require_relative "is_int.rb"

Funcs = %i(
  int_floor?
  int_ceil?
  int_round?
  int_truncate?
  int_to_i?
)

Inputs = [
  { name: "0.0", value:0.0 },
  { name: "1.0", value:1.0 },
  { name: "1.5", value:1.5 },
  { name: "2e19", value:2e19 },
  { name: "9e19/7", value:9e19/7 },
  { name: "NAN", value:Float::NAN },
  { name: "INF", value:Float::INFINITY },
  { name: "-0.0", value:-0.0 },
  { name: "1.5r", value:1.5r },
  { name: "1r", value:1r },
  { name: "9e19.to_r/7", value:9e19.to_r/7 },
]

results = {}

results[:to_i]=Inputs.each.with_object({}){ |kv, o |
  name = kv[:name]
  value = kv[:value]
  r = Funcs.map{ |func|
    begin
      method(func).call(value)
    rescue=>e
      "例外"
    end
  }.uniq
  raise "not uniq" unless r.size==1
  o[name]=r[0]
}

p results