#REGEX = /(?=(.*[aeiou].*){3})(?=(?<a>.)(?\k<a>))(?!.*(ab|cd|pq|xy).*).*/
REGEX = /^(?=(.*[aeiou].*){3,})(?=.*(?<a>.)?\k<a>.*)(?!.*(ab|cd|pq|xy).*).*$/

p File.readlines("input.txt", chomp: true).count{ it =~ REGEX }
z = 0
D = ("a".."z").to_a.map{ |a| a+a }
N = [ "ab", "cd", "pq", "xy"]
 File.readlines("input.txt", chomp: true).each do |s|
   # if s =~ REGEX
   #     z = z + 1
   #     puts "#{s} *"
   # else
   
        match = s =~ REGEX

        if (s.count("a|e|i|o|u") >= 3) && D.any? { |a| s.include?(a) } && !N.any? {|a| s.include?(a) }
       #     puts "#{s} * #{match ? '' : 'XXXXXXXXX'}"
            z = z + 1
        else 
        #      puts "#{s} * #{!match ? '' : 'OOOOOOOOOOO'}"
        end
    #end
 end

 puts z