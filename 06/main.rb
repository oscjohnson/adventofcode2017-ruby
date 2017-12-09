require 'set'

banks = File.open('input.txt').read.split.map(&:to_i)
# banks = [0, 2, 7, 0]
s = Set.new

count = 0
goal = nil

while true do
	max = banks.max
	max_index = banks.index(max)
	banks[max_index] = 0

	max.times { |i|
		banks[(max_index + 1 + i) % banks.length] += 1 
	}

	if goal then
		count += 1
	end
	h = banks.join(',')

	if (h == goal) then
		break
	end

	if s.include? h and !goal then
		goal = h
	else
		s.add(h)
	end
end

puts s.count + 1
puts count