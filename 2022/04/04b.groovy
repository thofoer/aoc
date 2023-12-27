println new File('input2.txt').text
        .split("\n")
        .collect{
            it.split(",")
                .collect{
                    b = it.split("-")
                    (b[0] as Integer)..(b[1] as Integer)
                }
        }
        .collect{
            i = it[0].intersect(it[1])
            i.size() != 0 ? 1 : 0
        }
        .sum()