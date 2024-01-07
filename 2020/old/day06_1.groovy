def input="""abc

a
b
c

ab
ac

a
a
a
a

b"""


println(input.split("\n\n").collect{ new HashSet(it.replaceAll("\n","").split("").toList()).size() }.sum())
