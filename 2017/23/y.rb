
d=e=f=g=h=0
c=b=65
b*=100
b+=100000
c=b
c+=17000
#j2 = callcc {|cc| cc}
loop do
#p (2...(b**0.5).to_i)
#gets
h+=1 if (2..(b).to_i).any?{|d| b%d==0 }
g=b
g-=c
(p h;exit)if g==0
b+=17
#j2.call(j2)
end