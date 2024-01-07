def input="""35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576"""

array = input.split("\n").collect { it as long }

def check(value, part) {
   l = part.collectMany{a->part.collect{b->[a, b ]}}.stream().filter{ it[0]!=it[1]}.toList()
   return l.any {  it[0]+it[1] == value}
}


25.upto(array.size()-1) {
    if(!check(array[it], array[it-25..it-1])) {
       	target=array[it]
    }
}

outer: for(a=0; a<array.size()-1; a++) {
	for(e=a+1; e<array.size(); e++) {
	 	sum = array[a..e].sum()				
		if (sum == target) {
			println( array[a..e].min()+array[a..e].max())
	 	}	
		else if (sum>target) {
			continue outer
		}
	}
}

