
list = (0..255).to_a
input = File.open('input.txt').read
lengths_single = input.split(',').map(&:to_i)
lengths = input.split("").map(&:ord).concat([17, 31, 73, 47, 23])

def knot(list, lengths, short: false)
	skip_size = 0
	current_position = 0

	(short ? 1 : 64).times {
		lengths.each {|length|
			shifted = list.rotate(current_position)
			list = shifted.take(length).reverse.concat(shifted.drop(length)).rotate(-current_position)
			current_position += (length + skip_size) % list.length
			skip_size +=1
		}
	}
	list
end

l = knot(list, lengths_single, short: true)

knot_hash = knot(list, lengths).each_slice(16).to_a.map{ |slice|
	slice.reduce(:^)
}.map{ |e| e.to_s(16)}.join

puts l[0] * l[1], knot_hash