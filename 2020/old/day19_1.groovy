input='''0: 4 1 5
1: 2 3 | 3 2
2: 4 4 | 5 5
3: 4 5 | 5 4
4: "a"
5: "b"

ababbb
bababa
abbbab
aaabbb
aaaabbb'''

data = input.split("\n\n")
rules=data[0].split("\n").stream().inject([:]) { a,e -> 
   row = (e =~ "(\\d+): (.*)")[0][1..-1]
   a[row[0]] = row[1]
   a
}
def transform(rule) {
println rule
   if (rule ==~ "\".\"") {
      (rule =~ "\"(.)\"")[0][1]
   }
   else if (rule.contains("|")) {
      def parts = (rule =~ "(.+) \\| (.+)")[0][1..-1]
      "(${transform(parts[0])}|${transform(parts[1])})"
   }
   else {
     rule.split(" ").collect { transform(rules[it]) }.join("")
   }

}

regex = transform(rules["0"])
println regex
println data[1].split("\n").stream().filter { it ==~ regex }.count()
