input='''42: 9 14 | 10 1
9: 14 27 | 1 26
10: 23 14 | 28 1
1: "a"
11: 42 31
5: 1 14 | 15 1
19: 14 1 | 14 14
12: 24 14 | 19 1
16: 15 1 | 14 14
31: 14 17 | 1 13
6: 14 14 | 1 14
2: 1 24 | 14 4
0: 8 11
13: 14 3 | 1 12
15: 1 | 14
17: 14 2 | 1 7
23: 25 1 | 22 14
28: 16 1
4: 1 1
20: 14 14 | 1 15
3: 5 14 | 16 1
27: 1 6 | 14 18
14: "b"
21: 14 1 | 1 14
25: 1 1 | 1 14
22: 14 14
8: 42
26: 14 22 | 1 20
18: 15 15
7: 14 5 | 1 21
24: 14 1

abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa
bbabbbbaabaabba
babbbbaabbbbbabbbbbbaabaaabaaa
aaabbbbbbaaaabaababaabababbabaaabbababababaaa
bbbbbbbaaaabbbbaaabbabaaa
bbbababbbbaaaaaaaabbababaaababaabab
ababaaaaaabaaab
ababaaaaabbbaba
baabbaaaabbaaaababbaababb
abbbbabbbbaaaababbbbbbaaaababb
aaaaabbaabaaaaababaa
aaaabbaaaabbaaa
aaaabbaabbaaaaaaabbbabbbaaabbaabaaa
babaaabbbaaabaababbaabababaaab
aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba'''

data = input.split("\n\n")
rules=data[0].split("\n").stream().inject([:]) { a,e -> 
   row = (e =~ "(\\d+): (.*)")[0][1..-1]
   a[row[0]] = row[1]
   a
}
def transform(rule) {
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
/*
regex1 = transform(rules["0"])
rules["8"] = "42 42"
rules["11"] = "42 42 31 31" 
regex2 = transform(rules["0"])
rules["8"] = "42 42 42"
rules["11"] = "42 42 42 31 31 31"
regex3 = transform(rules["0"])
rules["8"] = "42 42 42 42"
rules["11"] = "42 42 42 42 31 31 31 31"
regex4 = transform(rules["0"])
rules["8"] = "42 42 42 42 42 42 42 42"
rules["11"] = "42 42 42 42 42 42 42 42 31 31 31 31 31 31 31 31"
regex5 = transform(rules["0"])

println data[1].split("\n").stream().filter { it ==~ regex1 || it ==~ regex2 || it ==~ regex3 || it ==~regex4 || it ==~regex5}.count()
*/
regex = []

(1..10).forEach {
	rules["8"] = ("42 "*it).trim()
	rules["11"] = ("42 "*it + "31 "*it).trim()
	regex.add( "^"+transform(rules["0"] )+'$')
	println "${it} ${data[1].split('\n').stream().filter { s ->  regex.stream().any { s ==~ it }}.count()} "
}
