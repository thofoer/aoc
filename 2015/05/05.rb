REGEX_A = /^(?=(.*[aeiou].*){3})(?=.*(?<a>.)?\k<a>.*)(?!.*(ab|cd|pq|xy).*).*$/
REGEX_B = /^.*(?=.*(?<a>..).*\k<a>.*)(?=.*(?<b>.).\k<b>.*).*$/

strings = File.readlines "input.txt"
p strings.count{ it =~ REGEX_A }
p strings.count{ it =~ REGEX_B }