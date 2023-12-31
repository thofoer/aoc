input = File.read("input.txt").split("\n").map(&:to_i)
@jolts = [0, *input, input.max + 3].sort

@cache = {}

def solve(n)
    return @cache[n] if @cache[n]
    return 0 unless @jolts.include?(n)
    return 1 if n == 0

    @cache[n] = solve(n-3) + solve(n-2) + solve(n-1)
end

puts solve(@jolts.last)