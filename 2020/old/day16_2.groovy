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

def checkTicket(value) {
   rules.stream().noneMatch{ (it[1][0]<=value && it[1][1]>=value) || (it[2][0]<=value && it[2][1]>=value) }
}

myticket= data[1].split("\n")[1].split(",").collect { it as int }
tickets = data[2].split("\n")[1..-1].collect { it.split(",").collect{ it as int } }.stream().filter { !it.any{ checkTicket(it) } }.toList()

def check(rule, value) {
//println "${rule}    ${value}    ${ (rule[1][0]<=value && rule[1][1]>=value) || (rule[2][0]<=value && rule[2][1]>=value) }"
   (rule[1][0]<=value && rule[1][1]>=value) || (rule[2][0]<=value && rule[2][1]>=value) 
}

def checkRule(rule, values) {
//println("-----> ${rule}    ${values}    ${values.every { check(rule, it) }}")
    values.every { check(rule, it) }
}
ix=0
rules= rules.stream().collect { [it[0], it[1], it[2], ix++ ] }.toList()
println rules
res = (0..<tickets[0].size()).collect{
   i = it
   values = tickets.collect { it[i] }
   foundRule = rules.stream().filter {checkRule(it, values) }.toList()
   foundRule
}
ii=0
println "#################################################"
println res.forEach {print "${ii++} ${it.size()}\t";  it.sort().forEach { print "${it[0]}   "  }; println "" }
println "#################################################"




res.sort { a,b -> a.size() - b.size() }

for(i=1; i<res.size(); i++) {
    for(j=0; j<i; j++) {
        res[i].remove(res[j][0])
    }
}
res = res.collect { it[0] }
res.forEach { println it }
println "--------"
z = 1L
for(i=0; i<res.size(); i++) {
   if (res[i][0].startsWith("dep")) {
      z *= myticket[res[i][3]]
println res[i]
   }
}
println myticket
println 1L * myticket[17]*  myticket[11] *  myticket[8] *  myticket[14] *  myticket[6] *  myticket[1]

