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
println(
input.split("\n\n").collect{ it.split().collect{ new HashSet(it.split("").toList())} }.collect{ it.inject( ) { l,r -> l.intersect(r) } }.collect{  it.size()}.sum()
)
