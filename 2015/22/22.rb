BOSSLIFE, DAMAGE = File.readlines("input.txt").map{ it.scan(/(\d+)/)}.flatten.map(&:to_i)

class State    
    attr_reader :spent
    
    def initialize(turn=:p, mana=500, hp=50, poison=0, shield=0, recharge=0, spent=0, boss=BOSSLIFE)
        @turn, @mana, @hp, @poison, @shield, @recharge, @spent, @boss = turn, mana, hp, poison, shield, recharge, spent, boss        
    end

    def lose? = @mana < 53 || @hp <= 0    
    def win?  = @boss <= 0
    
    def missile  = (State.new(:b, @mana -  53, @hp,     @poison, @shield, @recharge, @spent + 53,  @boss - 4) if @mana >= 53)
    def drain    = (State.new(:b, @mana -  73, @hp + 2, @poison, @shield, @recharge, @spent + 73,  @boss - 2) if @mana >= 73)
    def shield   = (State.new(:b, @mana - 113, @hp,     @poison,       6, @recharge, @spent + 113, @boss)     if @mana >= 113 && @shield <= 0)
    def poison   = (State.new(:b, @mana - 173, @hp,           6, @shield, @recharge, @spent + 173, @boss)     if @mana >= 173 && @poison <= 0)
    def recharge = (State.new(:b, @mana - 229, @hp,     @poison, @shield,         5, @spent + 229, @boss)     if @mana >= 229 && @recharge <= 0)

    def turn(hard)        
        @boss -=   3 if @poison > 0
        @mana += 101 if @recharge > 0
        @poison -= 1
        @recharge -= 1
        @shield -= 1
        
        if @turn == :p
            @hp -= hard ? 1 : 0
            [missile, drain, shield, poison, recharge].compact
        else
            damage = DAMAGE - (@shield > 0 ? 7 : 0)
            [State.new(:p, @mana, @hp - damage, @poison, @shield, @recharge, @spent, @boss)]
        end
    end
end

def solve(hard)
    queue = []
    best = 100000
    queue.push State.new

    until queue.empty? do
        s = queue.pop    
        next if s.spent > best
        
        if s.win?
            best = [best, s.spent].min             
        elsif !s.lose?        
            s.turn(hard).each{ queue.push it }
        end
    end
    best
end

p solve(false), solve(true)