input="""class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12"""

data = input.split("\n\n")

rules = data[0].split("\n").stream().collect { (it =~ "(.*): (\\d+)-(\\d+) or (\\d+)-(\\d+)")[0][1..5] }.collect { [ it[0], [it[1] as int, it[2] as int], [it[3] as int, it[4] as int] ]}

def check(value) {
   rules.stream().noneMatch{ (it[1][0]<=value && it[1][1]>=value) || (it[2][0]<=value && it[2][1]>=value) }
}

println(
data[2].split("\n")[1..-1].collect { it.split(",").collect{ it as int } }.flatten().stream().filter { check(it) }.toList().sum()
)

