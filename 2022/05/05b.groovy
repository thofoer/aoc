def input = new File('input2.txt').text
def count = (input =~ /(?m)^(\s+\d+\s*)+$/)[0][0].trim().split(/\s+/).collect{ it as Integer }.max()
def plan = (input =~ /(?ms)(\s*\[.*\]+)/)[0][0]
def cmds = (input =~ /(?ms)(move.*)/)[0][0]
def stacks =(0..<count).collect{ new Stack()}

plan.split("\n")
    .each {
        for(int i=0; i<=it.length()>>2; i++) {
            c = it[1+4*i]
            if (c!=' ') {
                stacks[i].push(c)
            }
        }
    }

cmds.split("\n")
        .each {
            c = (it =~ /move (\d+) from (\d+) to (\d+)/)
            a = c[0][1] as Integer
            f = c[0][2] as Integer -1
            t = c[0][3] as Integer -1

            stacks[f][(0..<a)].reverse().each { stacks[t].insertElementAt(it, 0)}
            a.times{stacks[f].remove(0)}
        }

println stacks.collect{ it[0]}.join()