$prg = File.readlines("input.txt").map{|l| l.split}

$vars   = [Hash.new(0), Hash.new(0)]
$ptr    = [0, 0]
$queues = [[], []]

$count = 0

def step(pn)        
    cmd = $prg[$ptr[pn]] 
    op, arg1, arg2 = cmd
    val1 = arg1 =~ /[a-z]/ ? $vars[pn][arg1] : arg1.to_i
    val2 = arg2 =~ /[a-z]/ ? $vars[pn][arg2] : arg2.to_i
    
    case op
        when "snd" then $queues[pn] << val1; $count+=1 if pn==1
        when "set" then $vars[pn][arg1] = val2
        when "add" then $vars[pn][arg1] += val2
        when "mul" then $vars[pn][arg1] *= val2
        when "mod" then $vars[pn][arg1] %= val2        
        when "jgz" then $ptr[pn] += val2 unless val1 <= 0
        when "rcv" 
            unless $queues[pn ^ 1].empty?
                $vars[pn][arg1] = $queues[pn ^ 1].shift
            else
                return :waiting
            end
    end
 
    $ptr[pn] += 1 unless op == "jgz" && val1 > 0
    return :terminated if $ptr[pn] >= $prg.size

    :busy
end

$vars[0][?p] = 0
$vars[1][?p] = 1

loop do
    e0, e1 = :busy, :busy
    e0 = step(0) until e0 == :waiting    
    e1 = step(1) until e1 == :waiting        
    break if $queues.all?(&:empty?)
end

p $count