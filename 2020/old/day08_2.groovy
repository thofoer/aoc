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

def calc(code) {
	acc = 0
	visited =[] 
	z = 0;

	while (visited[z]==null && z<code.size()) {
		visited[z]=z
		if (code[z][0].equals("jmp"))  {
			   z += list[z][1]
		}
		else if(code[z][0].equals("acc")) {
			acc += list[z][1]
			z++
		}
		else {
			 z++
		}
	}
	return acc * (z==code.size() ? 1 : -1)
}

l=0
res=0;
do {
	testCode = input.split("\n").collect { (it =~ "(...) (.*)" ).collect { [it[1], it[2]as int] }}.collect{ it[0]}
 
	while (testCode[l][0].equals("acc") && l<testCode.size()) {
             l++
	}
	if (testCode[l][0].equals("nop")) {
		testCode[l][0]="jmp"
	}
	else {

		testCode[l][0]="nop"
	}
	l++			
	res = calc(testCode)
} while (res<=0)
println res 
