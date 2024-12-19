t, p = File.read("input.txt").split("\n\n")

@towels = t.scan(/([wubgr]+)/).flatten
patterns = p.split("\n")

def count(pattern)

    def countIter(pattern)    
        return @h[pattern] if @h[pattern]
        count = 0

        @t.filter{ pattern.start_with?(_1)}.each { |t| count +=  t == pattern ? 1 :  countIter(pattern[t.size..]) }
        @h[pattern] = count        
    end
    @h = {}
    @t = @towels.filter{ pattern.include?(_1)}    
    countIter(pattern)
end

p patterns.count{ count(_1) > 0 }
p patterns.sum{ count(_1) }
