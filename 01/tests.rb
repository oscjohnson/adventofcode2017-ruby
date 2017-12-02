require_relative 'main.rb'
 
def run_tests()
	tests = [
		["1122", 3],
		["1111", 4],
		["1234", 0],
		["91212129", 9],
	]

	tests.each{ |test|
		puts "#{run(test[0])} #{run(test[0]) == test[1]}"
	}
end

def run_tests2()
	tests = [
		["1212", 6],
		["1221", 0],
		["123425", 4],
		["123123", 12],
		["12131415", 4]
	]

	tests.each{ |test|
		puts "#{run(test[0], true)} #{run(test[0], true) == test[1]}"
	}
end

run_tests2()
run_tests()