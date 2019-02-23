require 'bundler'
Bundler.require

SRCES = [
  [ 'ceil', 'int_ceil?' ],
  [ 'floor', 'int_floor?' ],
  [ 'round', 'int_round?' ],
  [ 'to_i', 'int_to_i?' ],
  [ 'truncate', 'int_truncate?' ],
]

Benchmark.driver do |x|
  x.prelude( File.open("is_int.rb"){ |f| f.read } )
  SRCES.each do |name, func|
    inputs = %w( 0 1 1.5 3.14 2e19 )
    src = inputs.map{ |x|
      <<~"RUBY"
        #{func}(#{x})
      RUBY
    }.join( "\n" )
    x.report( name, src )
  end
end

Benchmark.driver do |x|
  x.prelude( File.open("is_int.rb"){ |f| f.read } )
  SRCES.each do |name, func|
    inputs = %w( 0r 1r 1.5r 3.14r 20000000000000000000r )
    src = inputs.map{ |x|
      <<~"RUBY"
        #{func}(#{x})
      RUBY
    }.join( "\n" )
    x.report( name, src )
  end
end