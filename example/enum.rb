fb = Fiber.new do  
    x, y = 0, 1 
    loop do  
      Fiber.yield y 
      x,y = y,x+y 
    end 
  end 
20.times { print fb.resume, " " }
puts


def fib(a,b)
    Enumerator.new do |yielder|        
        yielder << b        
        fib(b, a+b).each{yielder << it}
    end
end

p fib(0,1).take(20)
