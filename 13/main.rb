firewall = File.open('input.txt').readlines.inject([]) { |a, line|
	i, val = line.split(": ").map(&:to_i)
	a[i] = val;
	a
}

def wind(ticks, range)
	ticks = ticks % (range + range - 2)
	ticks = ticks - range if ticks > range
	ticks
end

def get_severity(firewall, offset = 0, breakable = false)
	arr = []
	firewall.each_with_index { |range, depth|
		if range and wind(depth + offset, range) == 0 then
			arr.push [range, depth]
			break if breakable
		end
	}
	arr
end

puts get_severity(firewall).map{|e| e.reduce(:*)}.sum
offset = 0
offset += 1 until get_severity(firewall, offset, true).size == 0
puts offset

