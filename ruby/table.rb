require_relative "is_int.rb"

FUNCS_TO_I = %i(
  int_floor?
  int_ceil?
  int_round?
  int_truncate?
  int_to_i?
)

INPUTS = [
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

results[:to_i]=INPUTS.each.with_object({}){ |kv, o |
  name = kv[:name]
  value = kv[:value]
  r = FUNCS_TO_I.map{ |func|
    begin
      method(func).call(value)
    rescue
      "例外"
    end
  }.uniq
  raise "not uniq" unless r.size==1
  o[name]=r[0]
}

FUNCS = [
  { name:"int32(比較)", f: :is_int32_1 },
  { name:"int32(pack/unpack)", f: :is_int32_2 },
]

FUNCS.each do |name:, f:|
  results[name]=INPUTS.each.with_object({}){ |kv, o |
    iname = kv[:name]
    value = kv[:value]
    r = begin
          method(f).call(value)
        rescue
          "例外"
        end
    o[iname]=r
  }
end

puts( "|入力|"+results.keys.map{ |k| k.to_s+"|" }.join("") )
puts("|:--|"+":--:|"*results.size)
INPUTS.each do |i|
  puts("|"+i[:name]+"|"+results.values.map{ |v| "#{v[i[:name]]}|" }.join("") )
end
