input = DATA.read.scan(/(\d+)/).flatten.map(&:to_i)
# input = [65,8921] # example
FACTORS = [16807,48271]
DIVISOR = 2147483647
a,b = input
count = 0

def lowest16bits(a)
	a.to_s(2).rjust(32, "0")[16..31]
end

40_000_000.times {
	a = a * FACTORS[0] % DIVISOR
	b = b * FACTORS[1] % DIVISOR
	count += 1 if lowest16bits(a) == lowest16bits(b)
}

puts count
count = 0
a,b = input

5_000_000.times {
	a = a * FACTORS[0] % DIVISOR
	a = a * FACTORS[0] % DIVISOR until a % 4 == 0
	b = b * FACTORS[1] % DIVISOR
	b = b * FACTORS[1] % DIVISOR until b % 8 == 0

	count += 1 if lowest16bits(a) == lowest16bits(b)
}

puts count

__END__
Generator A starts with 512
Generator B starts with 191

