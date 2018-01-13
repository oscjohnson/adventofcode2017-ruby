class Node
	def initialize(value)
		@value = value
	end
	def value
		@value
	end
	def next
		@next
	end
	def next=(n)
		@next = n
	end
end

def run(goal, progress = false)
	n = Node.new(0)
	n.next = n

	i = 0
	steps = 348

	goal.times {
		steps.times {
			n = n.next
		}
		nxt = n.next
		current = Node.new(i+=1)
		n.next = current
		current.next = nxt
		n = current

		if progress then
			puts 100*i/50_000_000.0 if i % 500_000 == 0
		end
	}

	n = n.next until n.value == goal

	n.next.value
end

puts run(2017)
puts run(50_000_000, true)

# 417 34334221