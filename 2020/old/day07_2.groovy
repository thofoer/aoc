def input="""shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags."""

map = input.split("\n").inject(new HashMap()) { s,e -> s.put(  (e =~ "(.*) bags contain.*")[0][1], (e=~"(\\d+) (.*?) bag[s]?").collect { [it[2], it[1] as int] }); s }


def count(bag) {
   if (map[bag]==[]) {
       return 1;
   }
    return 1+map[bag].collect { it[1] * count(it[0]) }.sum()
}
println( count("shiny gold")-1)

