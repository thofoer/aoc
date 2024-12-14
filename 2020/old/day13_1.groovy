input="""939
7,13,x,x,59,x,31,19"""


time = (input =~ "(\\d+)\n")[0][1] as int
dep= ((input =~ "\n(.+)")[0][1]).split(",").stream().filter { it != 'x' }.collect { it as int }.collect { [it, (1+(time / it) as int) * it]}.inject([0,Integer.MAX_VALUE]) { a,e -> e[1]<a[1] ? e : a }

println dep[0] * (dep[1]-time)

