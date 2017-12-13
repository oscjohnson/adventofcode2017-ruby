ins = File.open('input.txt').readlines

$max = -Float::INFINITY

registers = ins.inject(Hash.new(0)) { |registers, instruction|
	upd_r, op, upd_val, _, check_r, comp, check_val = instruction.split

	if registers[check_r].send(comp, check_val.to_i)
			registers[upd_r] = registers[upd_r].send(op == "inc" ? :+ : :-, upd_val.to_i)
			if (registers[upd_r] > $max) then $max = registers[upd_r] end
	end
	registers
}

puts registers.max_by{|k,v| v}[1]
puts $max