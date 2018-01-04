require_relative '../lib/knothash.rb'
require_relative '../lib/knot_hash.rb'
# test_input = flqrgnkx
input = "uugsqrei"
symbol_counter = 0

grid = (0..127).map{ |i|
	knothash("#{input}-#{i}").split("").map { |c|
		c.to_i(16).to_s(2).rjust(4, "0")
	}.join
}

def visit_neighbors(regions, symbol_counter, grid, k, i, j)
		deltas = [[1,0], [0,1], [-1,0], [0,-1]]
		deltas.each { |delta|
			x,y = delta[0] + i, delta[1] + j
			next if (x < 0 or y < 0 or x > 127 or y > 127)
			if grid[x][y] == "1" then
				grid[x][y] = (65 + symbol_counter % 57).chr
				regions[k].push([x,y])
				regions, grid = visit_neighbors(regions, symbol_counter, grid, k, x, y)
			end
		}
	return regions, grid
end

puts grid.join("\n").count "1"

regions = Hash.new
(0..127).each{ |i|
	(0..127).each{ |j|
		if grid[i][j] == "1"	then
			k = "#{i}-#{j}"
			grid[i][j] = (65 + symbol_counter % 57).chr
			regions[k] = []
			regions, grid = visit_neighbors(regions, symbol_counter, grid, k, i, j)
			symbol_counter += 1
		end
	}
}

puts regions.size

# DEBUG
# print grid.join "\n"

# 8194 1141
