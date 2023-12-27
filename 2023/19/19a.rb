workflowsInput, partsInput = File.read("input.txt").split("\n\n")


parts = partsInput.split("\n").map{|p| p.scan(/(\d+)/).to_a.flatten.map(&:to_i)}

@workflows = {}
ATTR = {'x' => 0, 'm' => 1, 'a' => 2, 's' => 3}

workflowsInput.split("\n").map do |w|
  name, rules = w.scan(/(.+){(.+)}/).to_a.flatten
  @workflows[name] = rules.split(?,)
end

def accepted?(part)
  curr = @workflows["in"]
  found = nil
  while found != ?A && found != ?R do
    for r in curr
      unless r.index(":").nil?
        attr, comp, value, target = r.scan(/(.)([<>])(\d+):(.*)/).to_a.flatten
        if part[ATTR[attr]].method(comp).call(value.to_i)
          found = target
          break
        end
      else
        found = r
      end
    end
    curr = @workflows[found]
  end
  found == ?A
end

puts parts.map{|q|accepted?(q) ? q.sum : 0}.sum