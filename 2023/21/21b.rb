@plots = Set.new
start = nil
File.read("input.txt").each_line.with_index do |l, y|
  l.chomp.each_char.with_index do |c, x|
    @plots << Complex(x,y) unless c == "#"
    start = Complex(x,y) if c == "S"
  end
end

DIRS  = [ 0-1i, 1+0i, 0+1i, -1+0i]
N     = @plots.map(&:real).max + 1
STEPS = 26501365

def dump(a, pos)
  (0...N).each do |y|
    (0...N).each do |x|
      print pos.include?(Complex(x,y)) ? ?O : a.include?(Complex(x,y)) ? ?. : ?#
    end
    puts
  end
end

# Beobachtungen:
#  * Feld is quadratisch mit Kantenlänge 131 (N)
#  * Startpunkt ist in der Mitte (65,65)
#  * Zentrale Zeile und Spalte sind frei von Hindernissen (#)
#  *   d.h. Ausbreitung linear möglich in alle vier Richtungen
#  *   d.h. nach 65 Schritten (t=0) ist das Startfeld bis zum Rand ausgefüllt
#  *   d.h. nach 65 + 131 Schritten (t=1) ist das Startfeld
#           und die vier angrenzenden Felder bis zum Rand ausgefüllt
#  *   d.h. nach 65 + 2*131 Schritten (t=2) ist das Startfeld, die vier angrenzenden Felder
#           und die 8 Felder angrenzend an diese Felder bis zum Rand ausgefüllt.
#
#                                        ▢
#                       ▢              ▢▢▢
#    t=0  ▢      t=1  ▢▢▢       t=2  ▢▢▢▢▢
#                       ▢              ▢▢▢
#                                        ▢
#
# Idee:
#  Summe der besuchten Felder wächst quadratisch.
#  Messwerte für t=0, t=1 und t=2 bestimmen und hiermit quadratische Gleichung konstruieren.
#  Endergebnis ist Wert der Gleichung an Position x = STEPS / N, da STEPS = 65 + 131 * x
#
# Formel:
#   f(x) = a*x^2 + b*x + c
#   f(0) = P
#   f(1) = Q
#   f(2) = R
#
#  f(0) = 0*x^2 + 0*b + c
#       = c
#  => c = R
#
#  f(1) = a*1^2 + b*1 + c
#       = a + b + c
#       = a + b + P
#       = Q
#
#  => a + b + P = Q
#             b =  Q - P - a    (1)
#
#  f(2) = a*2^2 + 2b + c
#       = 4a + 2b + c
#       = 4a + 2b + P
#       = R
#
#  =>  4a + 2b + P = R
#      4a           = R - 2b - P
#        a           = (R - 2b - P)/4  (2)
#
# (1) in (2)
#
#  a = (R - P - 2(Q - P - a)) / 4
#  a = (R - P - 2Q + 2P + 2a) / 4
#  a = (R + P - 2Q + 2a) / 4
# 4a =  R + P - 2Q + 2a
# 2a =  R + P - 2Q
#  a =  R/2 + P/2 - Q   (3)
#
# (3) in (1)
#
#  b = Q - P - (R/2 + P/2 - Q)
#  b = 2Q - 3P/2 - R/2
#
# =>
# f(x) = (R/2 + P/2 - Q) * x^2 + (2Q - 3P/2 - R/2) + P
#
#
samples = []
positions = Set.new << start

(5*N / 2 + 1).times do |i|

  if i % N == N / 2
    samples << positions.size 
    #dump(@plots, positions)
  end
  temp = Set.new
  positions.each do |p|
    DIRS.each do |d|
      n = d + p
      temp << n if @plots.include? Complex(n.real % N, n.imag % N)
    end
  end
  positions = temp
end

f = lambda { |n, p, q, r| (r/2 + p/2 - q) * n**2 + (2*q - 3*p/2 - r/2) * n + p }

print f.call(STEPS / N, *samples)
