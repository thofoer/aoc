strings = File.readlines "input.txt"
p strings.count{ it =~ /^(?=(.*[aeiou].*){3})(?=.*(?<a>.)\k<a>.*)(?!.*(ab|cd|pq|xy).*)/ }
p strings.count{ it =~ /(?=.*(?<a>..).*\k<a>.*)(?=.*(?<b>.).\k<b>.*)/ }                        
