input = File.open('input.txt').readlines.map(&:split)

puts input.map{|a| a.uniq.length == a.length ? 1 : 0}.sum
puts input.map{|l|
	a = l.map{|w| w.chars.sort.join}
	a.uniq.length == a.length ? 1 : 0
}.sum



