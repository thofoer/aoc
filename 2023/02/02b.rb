print File.read("input.txt").split("\n")
            .sum{ |a|                 
                  a.scan(/(\d+) red/)  .flatten.map(&:to_i).max *                    
                  a.scan(/(\d+) green/).flatten.map(&:to_i).max *
                  a.scan(/(\d+) blue/) .flatten.map(&:to_i).max                
            }

