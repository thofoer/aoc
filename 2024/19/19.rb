t, p = File.read("input.txt").split("\n\n")

@cache = {}
@towels = t.scan(/([wubgr]+)/).flatten
patterns = p.split("\n")

def count(pattern)  =
    @cache[pattern] ||= @towels.filter{ pattern.start_with?(_1)}.sum { |t|  t == pattern ? 1 :  count(pattern[t.size..]) }

counts = patterns.map{count _1}
p counts.count{_1 > 0 }, counts.sum
