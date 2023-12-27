@broadcaster = []
@modules = {}

IMP = [:low, :high]
class FlipFlop
  attr_accessor :name, :succ, :state

  def initialize(name, succ)
    @name = name
    @succ = succ
    @state = 0
  end

  def sendPulse(pulse, _)
    if pulse == :low
      @state ^= 1
      return @succ.map{|t| [IMP[@state], @name, t]}
    end
    []
  end
end

class Conjunction
  attr_accessor :name, :succ, :states

  def initialize(name, succ)
    @name = name
    @succ = succ
    @states = {}
  end

  def addInput(input)
    @states[input] = 0
  end

  def sendPulse(pulse, source)
    @states[source] = pulse
    sendPulse = @states.values.all?(:high) ? :low : :high
    @succ.map{|t| [sendPulse, @name, t]}
  end
end

File.read("input.txt").each_line do |l|
  type, name, succ = l.scan(/(.)(.+) -> (.+)/).to_a.flatten
  succ = succ.split(",").map(&:strip)
  case type
  when ?b
    @broadcaster = succ
  when ?%
    @modules[name] = FlipFlop.new(name, succ)
  when ?&
    @modules[name] = Conjunction.new(name, succ)
  end
end

conj = @modules.dup.keep_if{|_,v| v.instance_of? Conjunction}

@modules.values.each do |m|
  m.succ.each do |s|
    conj[s]&.addInput(m.name)
  end
end

@count = {:low => 0, :high => 0}
def push
  @count[:low] += 1
  queue = @broadcaster.map{|n| [:low, nil, n]}

  until queue.empty?
    pulse, source, target = queue.shift

    @count[pulse] += 1
    queue += @modules[target]&.sendPulse(pulse, source) || []
  end
end

1000.times { push }
print @count[:low] * @count[:high]
