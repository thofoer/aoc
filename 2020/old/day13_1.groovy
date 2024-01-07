input="""1001287
13,x,x,x,x,x,x,37,x,x,x,x,x,461,x,x,x,x,x,x,x,x,x,x,x,x,x,17,x,x,x,x,19,x,x,x,x,x,x,x,x,x,29,x,739,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,x,x,x,23"""


time = (input =~ "(\\d+)\n")[0][1] as int
dep= ((input =~ "\n(.+)")[0][1]).split(",").stream().filter { it != 'x' }.collect { it as int }.collect { [it, (1+(time / it) as int) * it]}.inject([0,Integer.MAX_VALUE]) { a,e -> e[1]<a[1] ? e : a }

println dep[0] * (dep[1]-time)

