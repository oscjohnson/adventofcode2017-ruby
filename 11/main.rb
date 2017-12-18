steps = File.open('input.txt').read.split(',')

x = 0
y = 0
max = 0

steps.each{ |step|
	case step
	when "n"
		y += 1
	when "ne"
		x += 1
		y += 1
	when "se"
		x += 1
	when "nw"
		x -= 1
	when "s"
		y -= 1
	when "sw"
		x -= 1
		y -= 1
	end
	max = [(x-y).abs, max].max
}

puts (x-y).abs, max