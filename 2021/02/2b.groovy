#!/usr/bin/groovy
inputText = new File('input.txt').text
input = inputText.split("\n")

(pos, depth) = input.inject([0, 0, 0]) { acc, line ->
        (pos, depth, aim) = acc
        value = line.find( /\d+/ ) as Integer
        switch (line.find( /\w+/ )) {
                case "down"   : aim += value; break 
                case "up"     : aim -= value; break
                case "forward": pos += value; 
                                depth += aim * value; break
        }
        [pos, depth, aim]
}
println( pos * depth ) 
