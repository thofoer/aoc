input = File.read("input.txt").split("\n")

class Hand
  attr_reader :cards, :bid, :order

  def initialize(line)
    @cards = line[0]
    @bid = line[1].to_i
    count  = @cards.split("").inject(Hash.new(0)) {|a, c| a[c] += 1; a}.filter{ |k,_| k != ?J}.values
    max = count.empty? ? 0 : count.max
    jokers = @cards.scan(/J/).count
    @order =
      if max + jokers == 5
        ?7
      elsif max + jokers == 4
        ?6
      elsif count.include?(3) && count.include?(2) ||
            jokers == 1 && count.count{ |v| v==2 } == 2 ||
            jokers == 2 && count.include?(2)
        ?5
      elsif max + jokers == 3
        ?4
      elsif count.count{ |v| v==2 } == 2 ||
            jokers == 1 && count.include?(2) ||
            jokers == 2
        ?3
      elsif max + jokers == 2
        ?2
      else
        ?1
      end
    @order += @cards.gsub("T", ":").gsub("J", "0").gsub("Q", "<").gsub("K", "=").gsub("A", ">")
  end
end

hands = input.map{|l| Hand.new(l.split)}

print hands.sort_by(&:order).map.with_index{ |h, i| (i + 1) * h.bid}.sum