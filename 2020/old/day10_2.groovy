def input="""28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3"""

array = input.split("\n").collect { it as int }
array = (array + 0 + (array.max() + 3)).sort()

diffs= ((0..array.size() - 2).collect { array[it + 1]-array[it] })

vier = (0..diffs.size() - 4).collect { diffs[it..it+3] }.stream().filter { it.every{it == 1} }.count() 
drei = (0..diffs.size() - 3).collect { diffs[it..it+2] }.stream().filter { it.every{it == 1} }.count() - 2 * vier
zwei = (0..diffs.size() - 2).collect { diffs[it..it+1] }.stream().filter { it.every{it == 1} }.count() - 3 * vier - 2 * drei

println ((2 as BigInteger) ** zwei * 4 ** drei * 7 ** vier )


