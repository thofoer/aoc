input = File.read("input.txt").split("\n\n")

puts input.count{ |p| %w[byr iyr eyr hgt hcl ecl pid].all?{|c| p.include?(c)}}

checkers = { 
    "byr" => lambda{|v| v.to_i.between?(1920, 2002)},
    "iyr" => lambda{|v| v.to_i.between?(2010, 2020)},
    "eyr" => lambda{|v| v.to_i.between?(2020, 2030)},
    "hgt" => lambda{|v| v && (s = v.scan(/^(\d+)(?:cm|in)$/).flatten.first.to_i; (v.include?("cm") ? 150..193 : 59..76).include?(s))},
    "hcl" => lambda{|v| v =~ /^#[0-9a-f]{6}$/},
    "ecl" => lambda{|v| %w[amb blu brn gry grn hzl oth].include?(v)},
    "pid" => lambda{|v| v =~ /^\d{9}$/},
    "cid" => lambda{|_| true }
}

p = input.map{ _1.scan(/...:[a-z#0-9]+/m).map{|q| q.split(?:)}.to_h}

puts p.map{|h| checkers.all?{|ck, cv| cv.call(h[ck])}}.count(true)
