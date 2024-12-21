codes = File.readlines("input.txt", chomp: true)

MOVES1 = { 
    "A0" => ["<"],
    "A1" => ["<^<", "^<<"],
    "A2" => ["<^", "^<"],
    "A3" => ["^"],
    "A4" => ["^^<<", "^<^<", "<^^<", "<^<^"],
    "A5" => ["^^<", "<^^", "^<^"],
    "A6" => ["^^"],
    "A7" => ["^^^<<", "^^<<^", "^<<^^", "^^<^<", "^<^<^", "<^<^^", "<^^<^", "<^^^<"],
    "A8" => ["^^^<", "<^^^"],
    "A9" => ["^^^"],

    "0A" => [">"],
    "01" => ["^<"],
    "02" => ["^"],
    "03" => ["^>", ">^"],
    "04" => ["^^<", "^<^"],
    "05" => ["^^"],
    "06" => ["^^>", ">^^"],
    "07" => ["^^^<", "^<^^", "^^<^"],
    "08" => ["^^^"],
    "09" => ["^^^>", ">^^^"],
    
    "1A" => [">>v", ">v>"],
    "10" => [">v"],
    "12" => [">"],
    "13" => [">>"],
    "14" => ["^"],
    "15" => ["^>", ">^"],
    "16" => ["^>>", ">>^", ">^>"],
    "17" => ["^^"],
    "18" => ["^^>", ">^^", "^>^"],
    "19" => ["^^>>", ">>^^", ">^>^", "^>^>", "^>>^", ">^^>" ],

    "2A" => [">v", "v>"],
    "20" => ["v"],
    "21" => ["<"],
    "23" => [">"],
    "24" => ["<^", "^<"],
    "25" => ["^"],
    "26" => ["^>", ">^"],
    "27" => ["^^<", "^<^", "<^^"],
    "28" => ["^^"],
    "29" => ["^^>", ">^^", "^>^"],
    
    "3A" => ["v"],
    "30" => ["v<", "<v"],
    "31" => ["<<"],
    "32" => ["<"],
    "34" => ["<<^", "^<<", "<^<"],
    "35" => ["<^", "^<"],
    "36" => ["^"],
    "37" => ["^^<<", "<<^^", "<^<^", "^<^<", "^<<^", "<^^<"],
    "38" => ["^^<", "<^^", "^<^"],
    "39" => ["^^"],

    "4A" => [">>vv", ">v>v", "v>v>", "v>>v", ">vv>"],
    "40" => [">vv", "v>v"],
    "41" => ["v"],
    "42" => ["v>", ">v"],
    "43" => ["v>>", ">v>", ">>v"],
    "45" => [">"],
    "46" => [">>"],
    "47" => ["^^"],
    "48" => ["^>", ">^"],
    "49" => ["^>>", ">^>", ">>^"],

    "5A" => [">vv", "v>v", "vv>"],
    "50" => ["vv"],
    "51" => ["<v", "v<"],
    "52" => ["v"],
    "53" => ["v>", ">v"],
    "54" => ["<"],
    "56" => [">"],
    "57" => ["^<", "<^"],
    "58" => ["^"],
    "59" => ["^>", ">^"],

    "6A" => ["vv"],
    "60" => ["vv<", "v<v", "<vv"],
    "61" => ["v<<", "<v<", "<<v"],
    "62" => ["v<", "<v"],
    "63" => ["v"],
    "64" => ["<<"],
    "65" => ["<"],
    "67" => ["^<<", "<^<", "<<^"],
    "68" => ["^<", "<^"],
    "69" => ["^"],

    "7A" => [">>vvv", ">vvv>", "v>>vv", "vv>>v", "v>v>v", ">v>vv", "vv>v>", "v>vv>"],
    "70" => [">vvv", "v>vv", "vv>v"],
    "71" => ["vv"],
    "72" => ["vv>", ">vv", "v>v"],
    "73" => ["vv>>", ">>vv", ">v>v", "v>v>", "v>>v", ">vv>"],
    "74" => ["v"],
    "75" => ["v>", ">v"],
    "76" => ["v>>", ">>v", ">v>"],
    "78" => [">"],
    "79" => [">>"],

    "8A" => [">vvv", "v>vv", "vv>v", "vvv>"],
    "80" => ["vvv"],
    "81" => ["vv<", "v<v", "<vv"],
    "82" => ["vv"],
    "83" => ["vv>", "v>v", ">vv"],
    "84" => ["v<", "<v"],
    "85" => ["v"],
    "86" => ["v>", ">v"],
    "87" => ["<"],
    "89" => [">"],

    "9A" => ["vvv"],
    "90" => ["<vvv", "v<vv", "vv<v", "vvv<"],
    "91" => ["vv<<", "<<vv", "<v<v", "v<v<", "<vv<", "v<<v"],
    "92" => ["<vv", "v<v", "vv<"],
    "93" => ["vv"],
    "94" => ["v<<", "<v<", "<<v"],
    "95" => ["v<", "<v"],
    "96" => ["v"],
    "97" => ["<<"],
    "98" => ["<"]
}

MOVES2 = {
    "AA" => [""],
    "A>" => ["v"],
    "A^" => ["<"],
    "Av" => ["<v", "v<"],
    "A<" => ["v<<","<v<"],

    "^A" => [">"],
    "^>" => ["v>", ">v"],
    "^^" => [""],
    "^v" => ["v"],
    "^<" => ["v<"],

    ">A" => ["^"],
    ">>" => [""],
    ">^" => ["<^", "^<"],
    ">v" => ["<"],
    "><" => ["<<"],

    "vA" => [">^", "^>"],
    "v>" => [">"],
    "v^" => ["^"],
    "vv" => [""],
    "v<" => ["<"],

    "<A" => [">>^", ">^>"],
    "<>" => [">>"],
    "<^" => [">^"],
    "<v" => [">"],
    "<<" => [""]

}

def seq(code, moves)    
    res = [""]
        pos = ?A
        code.chars.each do |c|      
            res = res.product(moves[pos+c]).map(&:join).flatten.map{_1+?A}
            pos = c
        end                
    res
end

def seq2(code)
    codes =  seq(code, MOVES1)
    c2 = codes.sort_by(&:length).first
    seq(c2, MOVES2)
end

def seq3(code)
    codes =  seq2(code)
    c3 = codes.sort_by(&:length).first
    seq(c3, MOVES2).sort_by(&:length).first
end

def seqlength(code)
    seq3(code).inject(10000){|a,c| c.length < a ? c.length : a}
end

#p seq("029A", MOVES1)
#p  seq(seq(seq(["029A"], MOVES1), MOVES2), MOVES2)

p codes.map{ |c| seq3(c).size }




#p seq(res1[1], MOVES2).size
#p seq(res1[2], MOVES2).size

#p codes.map {|c| seq(seq(seq(c, MOVES1), MOVES2), MOVES2).size * 1}

#codes.map{|c| p c}
#seq = seq(seq(seq("029A", MOVES1), MOVES2), MOVES2)
#
#p 29,seq.size

#    +---+---+
#    | ^ | A |
#+---+---+---+
#| < | v | > |
#+---+---+---+

#+---+---+---+
#| 7 | 8 | 9 |
#+---+---+---+
#| 4 | 5 | 6 |
#+---+---+---+
#| 1 | 2 | 3 |
#+---+---+---+
#    | 0 | A |
#    +---+---+

#p codes
#p moves

# <A^A>^^AvvvA, 
# <A^A^>^AvvvA, and 
# <A^A^^>AvvvA.

# v<<A>>^A<A>AvA<^AA>A<vAAA>^A
# v<<A>>^A<A>A<AA>vA^A<vAAA>^A
# v<<A>>^A<A>A<Av>A<^A>A<vAAA>^A

# v<<A>>^A<A>AvA<^AA>A<vAAA>^A   *************

# v<<A>>^A<A>AvA<^AA>A<vAAA>^A    1
# v<<A>>^A<A>A<Av>A<^A>A<vAAA>^A  2
# v<<A>>^A<A>A<AAv>A^A<vAAA>^A    3


### <vA<AA>>^AvAA<^A>A<v<A>>^AvA^A<vA>^A<v<A>^A>AAvA^A<v<A>A>^AAAvA<^A>A   ***********
### <vA<AA>>^AvAA<^A>Av<<A>>^AvA^Av<<A>>^AA<vA>A^A<A>Av<<A>A>^AAAvA<^A>A


#"<A^A^^>AvvvA", 
#"<A^A>^^AvvvA", 
#"<A^A^>^AvvvA"

# <A^A>^^AvvvA, 
# <A^A^>^AvvvA, and 
# <A^A^^>AvvvA.


#v<<A>>^A<A>AvA<^AA>A<vAAA>^A
#<v<A>>^A<A>A<AA>vA^A<vAAA>^A
#<v<A>>^A<A>A<AA>vA^A<vAAA^>A
#<v<A>>^A<A>A<AA>vA^Av<AAA>^A
#<v<A>>^A<A>A<AA>vA^Av<AAA^>A
#<v<A>>^A<A>A<AAv>A^A<vAAA>^A
#<v<A>>^A<A>A<AAv>A^A<vAAA^>A
#<v<A>>^A<A>A<AAv>A^Av<AAA>^A
#<v<A>>^A<A>A<AAv>A^Av<AAA^>A
#<v<A>^>A<A>A<AA>vA^A<vAAA>^A
#<v<A>^>A<A>A<AA>vA^A<vAAA^>A
#<v<A>^>A<A>A<AA>vA^Av<AAA>^A
#<v<A>^>A<A>A<AA>vA^Av<AAA^>A
#<v<A>^>A<A>A<AAv>A^A<vAAA>^A
#<v<A>^>A<A>A<AAv>A^A<vAAA^>A
#<v<A>^>A<A>A<AAv>A^Av<AAA>^A
#<v<A>^>A<A>A<AAv>A^Av<AAA^>A
#v<<A>>^A<A>A<AA>vA^A<vAAA>^A
#v<<A>>^A<A>A<AA>vA^A<vAAA^>A
#v<<A>>^A<A>A<AA>vA^Av<AAA>^A
#v<<A>>^A<A>A<AA>vA^Av<AAA^>A
#v<<A>>^A<A>A<AAv>A^A<vAAA>^A
#v<<A>>^A<A>A<AAv>A^A<vAAA^>A
#v<<A>>^A<A>A<AAv>A^Av<AAA>^A
#v<<A>>^A<A>A<AAv>A^Av<AAA^>A
#v<<A>^>A<A>A<AA>vA^A<vAAA>^A
#v<<A>^>A<A>A<AA>vA^A<vAAA^>A
#v<<A>^>A<A>A<AA>vA^Av<AAA>^A
#v<<A>^>A<A>A<AA>vA^Av<AAA^>A
#v<<A>^>A<A>A<AAv>A^A<vAAA>^A
#v<<A>^>A<A>A<AAv>A^A<vAAA^>A
#v<<A>^>A<A>A<AAv>A^Av<AAA>^A
#v<<A>^>A<A>A<AAv>A^Av<AAA^>