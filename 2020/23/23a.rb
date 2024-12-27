a = File.read("input.txt").split("").map(&:to_i)

def dump(a,c)
    a.each do |q|
        print ?( if c==q
        print q
        print ?) if c==q
        print " "
    end
    puts
end

def remove(a, i)
    a.delete_at(i % a.size)
end

def findDest(a, v)
    #puts "---> #{a.inspect}   #{v} " 
   f = v-1   
   
   loop do
     return a.index(f) if a.index(f)
     f = (f-1) % 10
   end
end

def insert(a, v, i)
  #  puts "insert #{a.inspect}  #{v}  #{i}"
    a.insert(i, v)
end

#dump(a,3)
ci=0
100.times do |zz|
   # puts "---------- #{zz+1} ---------------"
    current = a[ci]
    #dump(a,current)
    #toMove = [remove(a, ci+1), remove(a, ci+1), remove(a, ci+1)]
    toMove = (a+a)[(ci+1)..(ci+3)]
    toMove.each{a.delete(_1)}
    #puts "toMove #{toMove.inspect}"    
    dest = findDest(a, current)
    #puts "dest #{a[dest]}"    
    toMove.reverse.each{ insert(a, _1, dest+1) }
    #p a
    ci = (a.index(current)+1) % a.size
    #puts "newcurrent #{ci} = #{a[ci]}"
    # gets
    
end

puts (a+a)[a.index(1)+1...a.index(1)+9].map(&:to_s).join
 
# 389125467