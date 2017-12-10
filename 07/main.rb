require 'pp'
lines = File.open('input.txt').readlines.map(&:chomp)

def node_weight(tree, node_name)
	node = tree[node_name]
	children = node[:children]
	if children.size > 0 then
		return node[:weight] + children.map{ |child|
			node_weight(tree, child)
		}.sum
	else
		return node[:weight]
	end
end

def traverse(h, root, diff = nil)
	diff = (node_weight(h, h[root][:children][0]) - node_weight(h, h[root][:children][1])).abs if !diff

	# extract the single value in some fancier way
	temp = Hash.new(0)
	candidate = h[root][:children].map{|child|
		temp[node_weight(h, child)] += 1

		[child, node_weight(h, child)]
	}.group_by{ |arr|
		arr[1]
	}.select{ |k, v|
		v.length == 1
	}.shift

	if candidate then
		traverse(h, candidate[1][0][0], diff)
	else
		h[root][:weight] - diff
	end
end

tree = Hash.new
lines.each{|line|
	parts, *, node_children_unprocessed = line.gsub(/,/, "").split(/ -> /)
	node, weight_with_parens = parts.split
	weight = weight_with_parens.gsub(/[\(\)]/, "").to_i
	node_children = (node_children_unprocessed and node_children_unprocessed.split or [])

	tree[node] = {
		:weight => weight,
		:children => node_children
	}
}

root = (tree.keys - tree.values.map{|e| e[:children]}.flatten).first

puts root
puts traverse(tree, root)

