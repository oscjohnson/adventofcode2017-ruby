stream = File.open('input.txt').read

def run(stream)
	cursor = 0
	groups = 0
	score = 0
	garbage = false
	garbage_count = 0

	while cursor < stream.length
		if stream[cursor] == ?! then
			cursor += 2
			next
		end

		if garbage and stream[cursor] != ?> then
			garbage_count += 1
		end

		if stream[cursor] == ?<
			garbage = true
		elsif stream[cursor] == ?>
			garbage = false
		end	

		if garbage then cursor += 1 ; next end
		
		case stream[cursor]
		when ?{
			groups += 1
		when ?}
			score += groups
			groups -= 1
		end

		cursor += 1
	end

	[score, garbage_count]
end

puts run(stream).join ' ' # 16021, 7685
