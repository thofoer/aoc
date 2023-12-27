println new File('input2.txt').text.split("\n")
        .collect {
                l = it.length() >> 1
                z = it.substring(0,l).toSet().intersect(it.substring(l).toSet()).toArray()[0]
                val = z.charAt(0) - 'a'.charAt(0) + 1
                val < 0 ? val + 58 : val
        }
        .sum()