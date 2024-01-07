def input="""eyr:1972 cid:100
hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946

hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007"""

def x = input.split("\n\n")
def counter=0
x.each{
def z=it.split().join(" ")+" "
 print z 
if(z ==~ /.*hcl:#[0-9a-f]{6}.*/ && z ==~ /.*byr:(19[2-9][0-9]|2000|2001|2002).*/ && z ==~ /.*eyr:(202[0-9]|2030).*/ && z ==~ /.*hgt:((1[5-8][0-9]|190|191|192|193)cm|(59|6[0-9]|70|71|72|73|74|75|76)in).*/ && z ==~ /.*ecl:(amb|blu|brn|gry|grn|hzl|oth).*/ && z ==~ /.*pid:[0-9]{9} .*/ && z ==~ /.*iyr:(201[0-9]|2020).*/){

//if (z ==~ /.*hcl:.*/ && z ==~ /.*byr:.*/ &&  z ==~ /.*eyr:.*/ && z ==~ /.*hgt:.*/ && z ==~ /.*ecl:.*/ && z ==~ /.*pid:.*/ && z==~/.*iyr.*/ ) {
println " ja"
counter++
}
else {
println " nein"
}
}

println counter
println x.size()
