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

  def reset
    @state = 0
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
    sendPulse =  @states.values.all?(:high) ? :low : :high
    @succ.map{|t| [sendPulse, @name, t]}
  end

  def reset
    @states = @states.map{|k, _| [k, 0]}.to_h
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

def pushUntilLowPulse(name)

  queue = @broadcaster.map{|n| [:low, nil, n]}

  until queue.empty?
    pulse, source, target = queue.shift
    if target == name && pulse == :low
      return true
    end

    queue += @modules[target]&.sendPulse(pulse, source) || []
  end
end

def cycle(name)
  @modules.values.each(&:reset)
  (1..).find{pushUntilLowPulse(name)}
end

node = @modules.values.select{|m| m.succ.include? "rx"}.first
pred = node.states.keys

print pred.map{cycle(_1)}.reduce(&:lcm)