workflowsInput, _ = File.read("input.txt").split("\n\n")

@workflows = { "A" => ["A"], "R" => ["R"] }

workflowsInput.split("\n").map do |w|
  name, rules = w.scan(/(.+){(.+)}/).flatten
  @workflows[name] = rules.split(?,)
end

def solve(list, ranges)
  current, rest = list.first, list[1..]

  return ranges.map(&:size).reduce(&:*) if current == ?A
  return 0 if current == ?R
  return solve(@workflows[current], ranges) unless current.include? ?:

  attr, comp, value, target = current.scan(/(.)([<>])(\d+):(.*)/).flatten
  ix = "xmas".index(attr)
  value = value.to_i
  lower = comp == ?<

  r, cr, rr = ranges[ix], ranges.dup, ranges.dup
  cr[ix] = lower ? r.min..value-1 : value+1..r.max
  rr[ix] = lower ? value..r.max   : r.min..value

  solve(@workflows[target], cr) + solve(rest, rr)
end

print solve(@workflows["in"], [1..4000] * 4)
