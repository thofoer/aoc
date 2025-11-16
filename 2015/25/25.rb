row, column = File.read("input.txt").scan(/(\d+)/).flatten.map(&:to_i)

def sigma(n) = n * (n + 1) / 2
def offset(c, r) = 1 + sigma(c + r - 1) - r # == 1 + sigma(r - 1) + sigma(c + r - 1) - sigma(r)

v = offset(column, row)

code = 20151125

(v-1).times do
    code *= 252533
    code %= 33554393
end
p code

