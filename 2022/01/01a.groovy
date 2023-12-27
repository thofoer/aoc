inputText = new File('input2.txt').text
elves = inputText.split("\n\n")
cals = elves.collect {it.split("\n").collect {it as Integer}.sum()}
println cals.max()