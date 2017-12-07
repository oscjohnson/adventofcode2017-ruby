instructions = File.open('input.txt').readlines.map(&:to_i)

def run(instructions, complex = false)
	ip = 0
	counter = 0
	while ip < instructions.length
		plus = instructions[ip]
		if complex and plus >= 3 then
			instructions[ip] -= 1
		else
			instructions[ip] += 1
		end
		ip += plus
		counter += 1
	end

	return counter
end


puts run(instructions.clone), run(instructions.clone, true)