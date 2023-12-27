def input = new File('input2.txt').text.split("\n").collect{Eval.me(it)}.findAll{it!=null}

def isList(x) {
    x instanceof List
}
def isInt(x) {
    x instanceof Integer
}

// Liefert 1 oder -1, wenn Ergebnis feststeht, 0 -> weiter vergleichen
def compare(l, r) {

    if (isInt(l) && isInt(r)) {
        return l == r ? 0 : l<r ? 1 : -1
    }
    else if (isList(l) && isList(r)) {
        for(int i=0; i<l.size(); i++) {
            if (r[i]==null) {
                return -1
            }
            def cmp = compare(l[i], r[i]);
            if (cmp!=0) {
                return cmp;
            }
        }
        if (l.size()<r.size()) {
            return 1
        }
        return 0;
    }
    else if (isList(l) && isInt(r)) {
        return compare(l, [r]);
    }
    else if (isInt(l) && isList(r)) {
        return compare([l], r);
    }
}

def p1 = [[2]]
def p2 = [[6]]
input.add(p1)
input.add(p2)
input = input.sort { a,b -> compare(b,a)}

println ((input.indexOf(p1)+1) * (input.indexOf(p2)+1))
