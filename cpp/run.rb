require "open3"

def shell(cmd)
  Open3.popen3(cmd) do |_, o, _, w|
    o.each do |line|
      puts line
    end
    raise "fail" unless w.value.success?
  end
end

shell( "clang++ -std=c++17 is_int.cpp -o is_int 2>&1" )
shell( "./is_int 2>&1" )
