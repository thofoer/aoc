def input = new File('input2.txt').text

def matcher = input =~/(?mis)Monkey (\d+):.*?Starting items: (.*?)Operation: new = (.*?)Test: divisible by (\d+).*?If true: throw to monkey (\d+).*?If false: throw to monkey (\d+)/
monkeys = matcher.collect{ new Monkey(it) }

class Monkey {
    Integer number
    List<BigInteger> items
    String operation
    BigInteger opValue
    Integer testDiv
    Integer trueMonkey
    Integer falseMonkey
    Integer processCount

    Monkey(List<String> args) {
        number = args[1] as BigInteger
        items = args[2].split(",").collect{ it as BigInteger }
        if (args[3].trim() == "old * old") {
            operation = "square"
        }
        else {
            if (args[3].startsWith("old + ")) {
                operation = "plus"
            }
            else {
                operation = "mul"
            }
            opValue = args[3].substring(6) as BigInteger
        }

        testDiv = args[4] as BigInteger
        trueMonkey = args[5] as Integer
        falseMonkey = args[6] as Integer
        processCount = 0
    }

    String toString() {
        return "Monkey "+number+": "+items.join(", ")
    }

    void addItem(item){
        items.add(item)
    }
}

commonDiv = monkeys.collect{it.testDiv}.inject(1){ a,c -> a*c }
println commonDiv



def doRound() {
    monkeys.each { monkey ->
        //println monkey

        monkey.items.each { item -> {
            monkey.processCount += 1
            def level = item
            if (monkey.operation=="square") {
                level = level * level
            }
            else if (monkey.operation=="plus") {
                level += monkey.opValue
            }
            else {
                level *= monkey.opValue
            }
            level = level % commonDiv
            def test = (level % monkey.testDiv) == 0
            def next = test ? monkey.trueMonkey : monkey.falseMonkey
            monkeys[next].addItem(level)
            //println "item: "+item+" -> "+monkey.operation+" "+test+" "+next
        }}
        monkey.items = []
    }
}



10000.times {
//    print it
//    println monkeys
    doRound()
}

println monkeys

best = monkeys.collect{ it.processCount }.sort()
println best
println best[-1]
println best[-2]

println  best[-1] as BigInteger *  best[-2] as BigInteger
