#!/usr/bin/groovy

class SnailNumber {

    SnailNumber parent
    SnailNumber left
    SnailNumber right
    int value = -1

    SnailNumber() {}

    SnailNumber(term, p) {
       parent = p
       if (term instanceof Integer) {
           value = term
       }
       else {
           left   = new SnailNumber(term[0], this)
           right  = new SnailNumber(term[1], this)
       }
    }

    String toString() {
       value > -1 ? "${value}" :  "[${left},${right}]"
    }
  
    def isRight() {
        parent.right == this
    }
    def isLeft() {
        parent.left == this
    }
    def hasValue() {
        value != -1
    }
    
    def add(SnailNumber other) {
        parent = new SnailNumber()
        other.parent = parent
        parent.left = this
        parent.right = other
        parent.reduce()
        return parent
    }

    def depth() {
        parent == null ? 0 : 1 + parent.depth()
    }

    def findValueLeft() {
        if (isRight() && parent.left.hasValue()){
            return parent.left
        }
        def search = this
        def switchDir = false
        def found = false

        while(!found) {
            if (switchDir) {
                search = search.right
            }
            else if (search.isLeft()) {
                search = search.parent
                if (search.parent==null) {
                    return null
                }
            }
            else {
                switchDir = true
                search=search.parent.left
            }
            found = search.hasValue()
        }
        search
    }

    def findValueRight() {
        if (isLeft() && parent.right.hasValue()){
            return parent.right
        }
        def search = this
        def switchDir = false
        def found = false

        while(!found) {
            if (switchDir) {
                search = search.left
            }
            else if (search.isRight()) {
                search = search.parent
                if (search.parent==null) {
                    return null
                }
            }
            else {
                switchDir = true
                search=search.parent.right
            }
            found = search.hasValue()
        }
        search
    }

    def explode() {
        if (hasValue()) {
            return false
        }
        if (depth()!=4) {
            return left?.explode() || right?.explode()
        }
        def leftValTerm = left.findValueLeft()
        if (leftValTerm!=null) {
            leftValTerm.value += left.value
        }
        def rightValTerm = right.findValueRight()
        if (rightValTerm!=null) {
            rightValTerm.value += right.value
        }
        left  = null
        right = null
        value = 0
        return true
    }

    def split() {
        if (value < 10) {
            return left?.split() || right?.split()
        }
        def v = value>>1
        left  = new SnailNumber(v, this)
        right = new SnailNumber(value-v, this)
        value = -1
        return true
    }
    
    def reduce() {
        while( explode() || split() );
    }

    def magnitude() {
        hasValue() ? value : 3*left.magnitude() + 2*right.magnitude()
    }
}

terms  = new File('input.txt').text.split("\n").collect{ Eval.me(it) }

println ((terms.collectMany{ a -> terms.collect{ b -> [a,b] }})
        .findAll{ it[0].toString() != it[1].toString() }
        .collect{ new SnailNumber(it[0], null).add(new SnailNumber(it[1], null)).magnitude() }
        .max())


