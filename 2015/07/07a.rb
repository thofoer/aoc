TERMS = File.readlines("input.txt").map { it.scan(/(\w*) ?(\w*) ?(\w*) -> (.+)/).to_a.flatten}
    
def makeHash()
    f = {}
    TERMS.each do |a,b,c, r|
    al = a.match?(/^\d+$/) ? a.to_i : a
    bl = b.match?(/^\d+$/) ? b.to_i : b
    cl = c.match?(/^\d+$/) ? c.to_i : c

        if b.empty? && c.empty? && a.match(/^\d+$/)
            f[r] = [a.to_i, nil, nil]
        else
            if al != "NOT"
                al, bl = bl, al
            end
            f[r] = [al, bl, cl]
        end
    end
    f
end


def calc(f)

    while f[?a][0] == "" do 
        f.each do |k,v|    
            v[1] = f[v[1]][0] if !v[1].nil? && !f[v[1]].nil? && f[v[1]][0].class == Integer
            v[2] = f[v[2]][0] if !v[2].nil? && !f[v[2]].nil? && f[v[2]][0].class == Integer
            
            if v[1].class == Integer && (v[2].class == Integer || v[0] == "NOT" || v[0] == "")
                if v[0] == ""
                    v[0] = v[1]
                elsif v[0] == "NOT"
                    v[0] = 65536 + ~v[1]
                elsif v[0] == "OR"
                    v[0] = v[1] | v[2]
                elsif v[0] == "AND"
                    v[0] = v[1] & v[2]
                elsif v[0] == "LSHIFT"
                    v[0] = v[1] << v[2]
                elsif v[0] == "RSHIFT"
                    v[0] = v[1] >> v[2]
                end               
            end

        end
    end
    f[?a][0]
end

f = makeHash()
a = calc(f)
p a

f = makeHash()
f[?b] = [a, nil, nil]

p calc(f)