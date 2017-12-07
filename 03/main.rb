input = ARGV.empty? ? 361527 : ARGV[0].to_i

def run(input, part2 = false)
	x = 0
	y = 0
	grid = Hash.new
	grid["0-0"] = 1
	deltas = [[1, 0], [0, 1], [-1, 0], [0, -1]]

	number = 1
	steps_to_take = 1
	ticks = 0
	while number < input
		2.times {
			steps_to_take.times {
				i = ticks % deltas.length
				x = x + deltas[i][0]
				y = y + deltas[i][1]

				value = (deltas + [[1,1], [-1,1], [1,-1], [-1,-1]]).map { |p|
					a = x + p[0]
					b = y + p[1]
					grid.has_key?("#{a}-#{b}") ? grid["#{a}-#{b}"] : 0
				}.sum

				grid["#{x}-#{y}"] = value
				number += 1
				if value >= input and part2 then
					return value
				end

				if number >= input then
					return [x,y].map(&:abs).sum
				end
			}
			ticks += 1
		}
		steps_to_take += 1
	end
end

puts run(input)
puts run(input, true)
