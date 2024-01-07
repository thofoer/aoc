rules, messages = File.read("input.txt").split("\n\n")

@rules = rules.split("\n").map{|l| n, t = l.scan(/(\d+): (.*)/).flatten }.to_h

def transform(rule)    
    return ?a if rule.include? ?a
    return ?b if rule.include? ?b
    return rule.split(" ").map{|r| transform(@rules[r])}.join("") unless rule.include? ?|

    r, l = rule.scan(/(.*) \| (.*)/).flatten
    
    "(#{transform(r)}|#{transform(l)})"
end

regexes = []

(1..10).each do |i|
    (1..10).each do |j|        
        @rules["8"]  = ("42 " * i).strip
        @rules["11"] = ("42 " * j + "31 " * j).strip
        
        regexes << Regexp.new("^#{transform(@rules["0"])}$")           
    end
end

puts messages.split("\n").count{|m| regexes.any?{|re| m.match(re)}}
