input = File.read("input.txt").scan(/^\d+$/m).map(&:to_i)
player1 = input[0...input.size/2]
player2 = input[input.size/2..]


def game(player1, player2, recursive=false)    
    hist1, hist2 = Set.new, Set.new

    until player1.empty? || player2.empty?
        return [true, nil] if hist1.include?(player1) && hist2.include?(player2)
        hist1 << player1.dup
        hist2 << player2.dup
        p1, p2 = player1.shift, player2.shift 
        winner1 = p1 > p2
        if recursive && player1.size >= p1 && player2.size >= p2            
            winner1, _ = game(player1.dup[0...p1], player2.dup[0...p2], recursive)
        end
        if winner1
            player1 << p1 << p2
        else
            player2 << p2 << p1
        end        
    end    
    [player2.empty?, (player1+player2).reverse.map.with_index{ |v,i| v * (i+1)}.sum]
end

p game(player1.dup, player2.dup).last
p game(player1, player2, true).last