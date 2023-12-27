record Monkey(String name, String leftTerm, String operator, String rightTerm, Long value) {
}

monkeys = new File('input2.txt').text.split("\n").collect {line ->
    matcher = line =~ /(.*): (\d*)/
    if (matcher.matches()) {
        return new Monkey(matcher[0][1], null, null, null, matcher[0][2] as Long)
    }
    matcher  = line =~ /(.*): (.*) (.) (.*)/
    if (matcher.matches()) {
        return new Monkey(matcher[0][1], matcher[0][2], matcher[0][3], matcher[0][4], null)
    }

}.groupBy {it->it.name}


long getValue(Monkey monkey) {
    if (monkey.value != null) {
        return monkey.value
    }
    else {
        def l = getValue(monkeys.get(monkey.leftTerm))
        def r = getValue(monkeys.get(monkey.rightTerm))
        switch (monkey.operator) {
            case "+": return l+r
            case "-": return l-r
            case "*": return l*r
            case "/": return l/r
            default: throw new Exception("lkjhjkl")
        }
    }
}

println getValue(monkeys.get("root"))