input = "0,1,5,10,3,12,19"
max = 2020 //30000000 

lastIndex =null
list = input.split(",").collect { it as int }
ix = 1
indexMap = list.stream().inject([:]) { a,e -> a[e]=ix++; a }

(list.size()..<max).stream().forEach {

   last = list[it-1]
   sz = indexMap[last]

   if (lastIndex!=null) {
       indexMap[lastIndex] = it
   }

   if (sz==null) {
       list[it] = 0
       lastIndex = 0
   }
   else {
       list[it] = it-sz
       lastIndex = it-sz
   }
}

println list[max-1]
