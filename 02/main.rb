input = File.open('input.txt').read.split("\n").map{|l| l.split.map(&:to_i)}

part1 = input.map{|x| x.minmax.each_cons(2).map{|a,b| b - a} }.flatten.sum
part2 = input.map{|x| x.combination(2)}.map{|x| x.map(&:sort).select{|e| e[1] % e[0] == 0 }.map{|a| a[1] / a[0]} }.flatten.sum

puts part1, part2
