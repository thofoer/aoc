codes = File.readlines("input.txt", chomp: true)

NUMPAD = [
   [?7, 0+0i],   [?8, 1+0i],   [?9, 2+0i],
   [?4, 0+1i],   [?5, 1+1i],   [?6, 2+1i],
   [?1, 0+2i],   [?2, 1+2i],   [?3, 2+2i],
                 [?0, 1+3i],   [?A, 2+3i]
].to_h

DIRPAD = [
                 [?^, 1+0i],   [?A, 2+0i],
   [?<, 0+1i],   [?v, 1+1i],   [?>, 2+1i]
].to_h

DIRS = { ?> => 1+0i, ?v => 0+1i, ?< => -1+0i, ?^ => 0-1i }

def forbidden(level) = level==0 ? 0+3i : 0+0i
def startpos (level) = level==0 ? 2+3i : 2+0i
def pad(level)       = level==0 ? NUMPAD : DIRPAD 

def singlestep(pos, target, level)        
    forbidden = forbidden(level)
    delta = target - pos
    h = (delta.real > 0 ? ?> : ?<) * delta.real.abs
    v = (delta.imag > 0 ? ?v : ?^) * delta.imag.abs
 
    (h+v).chars
           .permutation
           
           .uniq
           .reject{ |c| c.inject([pos]){ |a,m| a << a.last + DIRS[m]}.include?(forbidden) }
           .map(&:join)
           .map{it.concat(?A)}
end

def solve(code, maxdepth)
    $cache = {}

    def solveIter(code, maxdepth, level=0)
        key = [code, level]  
        return $cache[key] if $cache[key]

        pos = startpos(level)
        pad = pad(level)
        length = 0
        code.chars.each do |c|
            seq = singlestep(pos, pad[c], level)
            length += maxdepth == level ? seq.first.length 
                                        : seq.map{ |s| solveIter(s, maxdepth, level+1)}.min
            pos = pad[c]
        end
        $cache[key] = length
        length
    end
    solveIter(code, maxdepth) * code[0..2].to_i
end

p codes.sum{ solve(it,  2) }
p codes.sum{ solve(it, 25) }