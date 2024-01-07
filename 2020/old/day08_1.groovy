def input="""nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6"""

list = input.split("\n").collect { (it =~ "(...) (.*)" ).collect { [it[1], it[2]as int] }}.collect{ it[0]}

acc = 0
visited =[] 
z = 0;

while (visited[z]==null) {
visited[z]=z
if (list[z][0]=="jmp")  {
   z += list[z][1]
}
else if(list[z][0]=="acc") {
acc += list[z][1]
z++
}
else {
 z++
}}
println acc
