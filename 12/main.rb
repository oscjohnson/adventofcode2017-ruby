require 'set'
lines = File.open('input.txt').readlines.map(&:chomp)

connections = Hash.new

lines.each{|line|
	program, programs_ = line.split(" <-> ")

	programs = programs_.split(', ')

	if connections[program] then
		connections[program].push(programs)
	else
		connections[program] = programs.clone
	end
}

def f(connections, s, nodes)
	nodes.each{|node|
		if not s.include?(node) then
			s.add(node)
			children = connections[node]
			f(connections, s, children)
		end
	}
	s
end
puts f(connections, Set.new, ["0"]).size

s = Set.new 
(0..1999).each{|i|
	s.add f(connections, Set.new, [i.to_s]).to_a.sort.join
}
puts s.size

# 115 221