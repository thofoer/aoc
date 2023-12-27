def cubes = new File('input2.txt').text.split("\n").collect { Eval.me("["+it+"]")}

def touches(a, b) {
    (0..2).collect{ Math.abs(a[it]-b[it])}.sum() == 1
}

c = 0;
for(int i=0; i<cubes.size()-1; i++) {
    for(int j=i+1; j<cubes.size(); j++) {
        if (touches(cubes[i], cubes[j])) {
            c++;
        }
    }
}

println(cubes.size() * 6 - 2*c)