rules, messages = File.read("sample2.txt").split("\n\n")

@rules = rules.split("\n").map{|l| n, t = l.scan(/(\d+): (.*)/).flatten }.to_h

def transform(rule)    
    return ?a if rule.include? ?a
    return ?b if rule.include? ?b
    return rule.split(" ").map{|r| transform(@rules[r])}.join("") unless rule.include? ?|

    r, l = rule.scan(/(.*) \| (.*)/).flatten
    
    "(#{transform(r)}|#{transform(l)})"
end

regex = Regexp.new("^#{transform(@rules["0"])}$")


print messages.split("\n").count{|m| regex.match m}
