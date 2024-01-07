def zahlen = "1721 979 366 299 675 1456"
def array = zahlen.split(" ").collect { it as int }

array.forEach( {a ->  array.forEach({b -> array.forEach({ c-> if (a+b+c==2020) println(a*b*c)}) }) })
