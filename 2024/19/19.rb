t, p = File.read("input.txt").split("\n\n")

@cache = {}
@towels = t.scan(/([wubgr]+)/).flatten
patterns = p.split("\n")

def count(pattern)  =
    @cache[pattern] ||= @towels.filter{ pattern.start_with?(_1)}.sum { |t|  t == pattern ? 1 :  count(pattern[t.size..]) }

count = patterns.map{count _1}
p count.count{_1 > 0 }
p count.sum
