input = File.read("input.txt").scan(/Game (\d+): (.*)/)
            .map{ |a| 
                [ a[0].to_i, 
                  a[1].scan(/([^;]+)(?:; )?/)
                      .flatten
                      .map { |e| e.scan(/([^,]+)/)}
                      .map { |e| e.reduce({}){ |a, x| s = x[0].split(" "); a[s[1].to_sym]=s[0].to_i; a}}            
                ]
            }

m = {"red": 12, "green": 13, "blue": 14}

print input.select{ |e| e[1].all?{ |h| h.all? { |q| q[1] <= m[q[0]]}}}
           .sum{ |e| e[0] }
