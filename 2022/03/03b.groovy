println new File('input2.txt').text.split("\n")
        .collate(3)
        .collect {
            z = it[0].toSet().intersect(it[1].toSet()).intersect(it[2].toSet()).toArray()[0]
            val = z.charAt(0) - 'a'.charAt(0) + 1
            val < 0 ? val + 58 : val
        }
        .sum()
