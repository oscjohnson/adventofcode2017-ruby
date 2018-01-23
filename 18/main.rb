instructions = DATA.readlines.map(&:chomp)

class String
    def is_i?
       !!(self =~ /\A[-+]?[0-9]+\z/)
    end
end

tone = ''
x = {
	:waiting => false,
	:ip => 0,
	:count => 0,
	:registers => ("a".."z").map{|k,v| [k,0]}.to_h
}

y_registers = ("a".."z").map{|k,v| [k,0]}.to_h
y_registers["p"] = 1
y = {
	:waiting => false,
	:ip => 0,
	:count => 0,
	:registers => y_registers
}

x_q = []
y_q = []

$tone = nil
$part1 = nil
def process(p, read_q, write_q, line, opts = {})
	waiting = false
	ins, a, b = line.split
	x = (a.is_i? ? a : p[:registers][a]).to_i
	y = (b and b.is_i?) ? b.to_i : p[:registers][b].to_i
	case ins
		when "set"
			p[:registers][a] = y
		when "mul"
			p[:registers][a] *= y
		when "add"
			p[:registers][a] += y
		when "mod"
			p[:registers][a] %= y
		when "jgz"
			p[:ip] += y - 1	if x > 0
		when "rcv"
			if opts[:message_queue] then
					if read_q.size == 0
						waiting = true
					else
						p[:registers][a] = read_q.shift	
					end
				else
					if x > 0 and not $part1 then
						$part1 = $tone
						return
					end
			end
		when "snd"
			if opts[:message_queue] then
				p[:count] += 1
				write_q.push(x)
			else
				$tone = x
			end
	end
	p[:waiting] = waiting
	return p
end

until $part1 do
	process(x, [], [], instructions[x[:ip]])
	x[:ip] += 1
end
puts $tone

x[:ip] = 0
x[:registers] = ("a".."z").map{|k,v| [k,0]}.to_h

while x[:ip] < instructions.size and x[:ip] >= 0 do
	process(x, x_q, y_q, instructions[x[:ip]], {:message_queue => true})
	process(y, y_q, x_q, instructions[y[:ip]], {:message_queue => true})

	x[:ip] += 1 unless x[:waiting]
	y[:ip] += 1 unless y[:waiting]

	if x[:waiting] and y[:waiting]
		puts y[:count]
		break
	end
end

# 8600 7239

__END__
set i 31
set a 1
mul p 17
jgz p p
mul a 2
add i -1
jgz i -2
add a -1
set i 127
set p 735
mul p 8505
mod p a
mul p 129749
add p 12345
mod p a
set b p
mod b 10000
snd b
add i -1
jgz i -9
jgz a 3
rcv b
jgz b -1
set f 0
set i 126
rcv a
rcv b
set p a
mul p -1
add p b
jgz p 4
snd a
set a b
jgz 1 3
snd b
set f 1
add i -1
jgz i -11
snd a
jgz f -16
jgz a -19