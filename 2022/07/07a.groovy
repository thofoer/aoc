def input = new File('input1.txt').text.split("\n")
def dirName = new Stack()
def dirSize = [:]

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

println dirSize
        .entrySet()
        .findAll {it.value<=100000 }
        .collect{it.value }
        .sum()