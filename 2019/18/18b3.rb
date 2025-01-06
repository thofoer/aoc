require 'pairing_heap'
PrioQueue =  PairingHeap::MinPriorityQueue
State = Struct.new(:pos, :dist, :doors)
SolveState = Struct.new(:bots, :dist, :keys)
Key = Struct.new(:pos, :id, :doors)
Bot = Struct.new(:pos, :env)

DIRS = [-1+0i, 0-1i, 1+0i, 0+1i]

def isKey(c)  = c =~ /[a-z]/
def isDoor(c) = c =~ /[A-Z]/

sss = Time.now
$grid = Set.new
$doors, $keys = {}, {}
start = nil

File.readlines("sample5.txt", chomp: true).each_with_index do |l, y|
  l.chars.each.with_index do |c, x|
    p =  Complex(x,y)
    $grid << p unless c == ?#
    start = p if c == ?@
    $doors[p] = c.downcase if isDoor(c)
    $keys[p]  = c if isKey(c)
  end
end

def makeDistMap
  distMap = Hash.new{|h,k| h[k] = {} }

  $grid.each do |pos|
    dists = {}
    state = State.new(pos, 0)
    visited = Set.new([pos])
    queue = [state]
    until queue.empty?
      cur = queue.shift
      DIRS.each do |d|
        npos = cur.pos + d
        unless visited.include? npos
          visited << npos
          if $grid.include?(npos)
            dists[npos] = cur.dist + 1
            queue << State.new(npos, cur.dist + 1)
          end
        end
      end
    end
    distMap[pos] = dists
  end
  distMap
end


def scanEnvironment(pos)
  environment = []
  state = State.new(pos, 0, Set.new)
  visited = Set.new([pos])
  queue = [state]
  until queue.empty?
    cur = queue.shift
    DIRS.each do |d|
      npos = cur.pos + d
      unless visited.include?(npos)
        visited << npos
        newdoors = cur.doors.dup
        environment << Key.new(npos, $keys[npos], cur.doors) if $keys.include?(npos)
        newdoors << $doors[npos].downcase if $doors.include?(npos)
        queue << State.new(npos, cur.dist + 1, newdoors) if $grid.include?(npos)
      end
    end
  end
  environment
end

def makeBotId(bots, keys)
  bots.map(&:pos).map{|c| "r#{c.imag}c#{c.real}"}.join + keys.to_a.sort.join
end
bots = [-1-1i, 1-1i, 1+1i, -1+1i].map{ Bot.new(start + it, scanEnvironment(start + it))}

def solve(bots, dists)
  solved = false
  start = { :b => bots.map(&:dup), :d => 0, :k => Set.new, :id =>  makeBotId(bots, Set.new)}
  seen = {}
  seen[start[:id]] = 0

  queue = PrioQueue.new
  queue.push start

  until queue.empty? || solved
    cur = queue.pop
    puts "CURRENT #{cur.inspect}"
    next if seen[cur[:id]] < cur[:d]
    (0..3).each do |i|
      puts "BOT = #{cur[:b][i].inspect}"
      bots[i].env.each do |key|
        puts "KEY = #{key.inspect}"

        if !cur[:k].include? key.id
          p "#{cur[:k]}   #{key.id}"
          p "r#{cur[:b][i].pos.imag}c#{cur[:b][i].pos.real}", "r#{key.pos.imag}c#{key.pos.real}"
          #gets
          reachable = true
          key[:doors].each do |door|
            reachable = false unless cur[:k].include? door
          end
          if reachable

            puts "============================"

            puts "current bot: #{cur[:b][i]}  #{i}"
            puts "current key: #{key.pos}"
            p dists

            dist = dists[cur[:b][i].pos][key.pos]
            p dist
            #  gets

            nd = cur[:d] + dist
            nk = cur[:k].dup
            nk << key.id
            return nd if nk.size == $keys.size

            nb = cur[:b].map(&:dup)
            nb[i].pos = key.pos
            nid = makeBotId(nb, nk)
            if !seen[nid] || seen[nid] > nd
              #p "PUSH #{{:b=>nb, :d=>nd, :k=>nk, :id=>nid}}, #{nd}"
              queue.push({:b=>nb, :d=>nd, :k=>nk, :id=>nid}, nd)
              seen[nid] = nd
            end
          end
        end
      end
    end
  end
end
dists = makeDistMap
p solve(bots, dists)

p Time.now - sss
