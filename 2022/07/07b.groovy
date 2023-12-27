def input = new File('input2.txt').text.split("\n")
def dirName = new Stack()
def dirSize = [:] as Map<String, Integer>

input.each {line ->
        if (line.startsWith("\$ cd ")) {
                name = line.substring(5)
                if (name == "..") {
                        dirName.pop()
                }
                else {
                        dirName.push(name)
                }
        }
        else if (line ==~ "^\\d+ .*") {
                size = line.substring(0, line.indexOf(" ")) as Integer
                for (int i=0; i<dirName.size(); i++) {
                        curDir = dirName[(0..i)].join("/")
                        dirSize[curDir] = (dirSize[curDir] != null ? dirSize[curDir] : 0) + size
                }
        }
}
needed = 30000000 - (70000000 - dirSize["/"])

println dirSize
        .entrySet()
        .collect { it.value - needed }
        .findAll { it > 0 }
        .min() + needed
