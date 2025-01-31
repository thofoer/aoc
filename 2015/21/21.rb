BHP, BATT, BDEF = File.read("input.txt").scan(/(\d+)/).flatten.map(&:to_i)

Weapon = Struct.new(:cost, :attack ) do def defense = 0 end
Armour = Struct.new(:cost, :defense) do def attack  = 0 end
Ring   = Struct.new(:cost, :attack, :defense)

weapons = [[8, 4], [10, 5], [25, 6], [40, 7], [74, 8]].map{ Weapon.new(*it)}
armour  = [[0, 0], [13, 1], [31, 2], [53, 3], [75, 4], [102, 5]].map{ Armour.new(*it)}
rings   = [[25, 1, 0], [50, 2, 0], [100, 3, 0], [20, 0, 1], [40, 0, 2], [80, 0, 3]].map{ Ring.new(*it)}

ringcomb =  [[Ring.new(0, 0, 0)]] + rings.map{[it]} + rings.combination(2).to_a

gear = weapons.product(armour, ringcomb).map(&:flatten).sort_by{ it.sum(&:cost) }

def win?(gear)
    attack  = gear.sum(&:attack)
    defense = gear.sum(&:defense)    
    enemy = BHP
    health = 100

    loop do
        a = attack - BDEF
        enemy -= a > 1 ? a : 1
        b = BATT - defense        
        health -= b > 1 ? b : 1
        return true if enemy <= 0
        return false if health <= 0
    end
end

p gear.find{ win?(it) }.sum(&:cost)
p gear.reverse.find{ !win?(it) }.sum(&:cost)
