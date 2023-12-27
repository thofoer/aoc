@input = File.read("2023/12/input2.txt")
             .split("\n")
             .map { |l| l.scan(/([.?#]+) ([\d,]+)/).flatten }

@cache = Hash.new

def mem(map, runs, value)
  @cache[[map,runs]] = value
  value
end

## Prüfen, ob Konstellation aus map und runs möglich ist.
## Es wird der erste run aus der Liste mit der map (von links) verglichen.
## Passt es nicht, so wird 0 zurück geliefert
## Falls doch, wird solve rekursiv mit den übrigen runs und der
def check(map, runs)
   r = @cache[[map,runs]]
   return r unless r.nil?

   # Konstellation nicht möglich, wenn keine runs mehr vorhanden sind (map-Länge ist hier > 0)
   return 0 if runs.empty?

   # den ersten run aus der Liste betrachten (Länge ist l)
   l = runs.first

   # Konstellation nicht möglich, wenn map kürzer als zu prüfender run -> 0
   return 0 if map.length < l

   # die nächsten l (run-Länge) Stellen in map prüfen. Hier dürfen nur '?' und '#' stehen, sonst -> 0
   return 0 if map[0...l].include? '.'

   # Wenn die map nur den aktuellen run enthält
   if map.length == l
     # Wenn dies der einzige (d.h. letzte) run ist, passt die Konstellation -> 1
     return 1 if runs.size == 1
     # Wenn es noch mehr runs gibt, obwohl map schon abgedeckt ist -> 0
     return 0
   end

   # Wenn in der map nach dem run ein '#' kommt, ist der run zu kurz, also passt Konstellation nicht -> 0
   return 0 if map[l] == "#"

   # Wenn erster run gepasst hat, diesen aus Liste und map (plus 1 zusätzliche Stelle als Trenner zum nächsten run)
   # entfernen und den Rest rekursiv berechnen
   calc(map[(l+1)..], runs[1..])
end

## Berechne Anzahl Möglichkeiten für runs in map
def calc(map, runs)

  if map.empty?
    # Rekursion abbrechen, wenn map vollständig abgearbeitet ist.
    # Falls alle runs gepasst haben (runs-Liste ist leer), ist Zustand möglich -> 1, andernfalls nicht -> 0
    return runs.empty? ? 1 : 0
  end

  case map[0]
  when "."
    # leere Stellen ('.') einfach überspringen
    return calc(map[1..], runs)
  when "#"
    # bei '#' die Anzahl der Möglichkeiten rekursiv berechnen
    return mem(map, runs, check(map, runs))
  when "?"
    # bei '?' die Summe der beiden oberen Fälle verwenden:
    #   1. '?' wird als '.' angenommen
    #   2. '?' wird als '#' angenommen
    return calc(map[1..], runs) + mem(map, runs, check(map, runs))
  end
end


def solve(factor = 1)

  @input.map { |row,s|
                      calc(
                            ([row] * factor).join("?"),
                            s.scan(/\d+/).map(&:to_i) * factor
                      )
  }.flatten.sum
end

print "Part 1: #{solve}\n"
print "Part 2: #{solve(5)}\n"
