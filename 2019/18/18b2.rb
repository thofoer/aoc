require 'pairing_heap'
PrioQueue =  PairingHeap::MinPriorityQueue
DIRS = [-1+0i, 0-1i, 1+0i, 0+1i]

def dump(f)
    f.each{ puts it}
end

start = nil
sss = Time.now

f = File.readlines("input.txt", chomp: true)
sr, sc = nil , nil
H = f.size
W = f[0].size
keys = []
bots = []

(0...H).each do |r|
  (0...W).each do |c|
    (sr = r; sc = c) if f[r][c] == ?@
    keys << f[r][c] if f[r][c] =~ /[a-z]/
  end
end


p sr, sc, keys

f[sr-1][sc] = ?#
f[sr+1][sc] = ?#
f[sr][sc-1] = ?#
f[sr][sc+1] = ?#

bots << [sr-1, sc-1]
bots << [sr-1, sc+1]
bots << [sr+1, sc+1]
bots << [sr+1, sc-1]


def findAllDists(f)
    allDists = {}
    (0...H).each do |r|
        (0...W).each do |c|
            if f[r][c] != ?#
                dists = {}
                start = { :r => r, :c => c, :d => 0, :id => "r#{r}c#{c}"}
                seen = Set.new([start[:id]])
                queue = [start]
                until queue.empty?
                    cur = queue.shift
                    DIRS.each do |d|
                        nr = cur[:r] + d.imag
                        nc = cur[:c] + d.real
                        nid = "r#{nr}c#{nc}"
                        unless seen.include? nid
                            seen << nid
                            if f[nr][nc] != ?#
                                dists[nid] = cur[:d] + 1
                                queue << { :r => nr, :c => nc, :d => cur[:d]+1, :id => nid}
                            end
                        end
                    end
                end
                allDists["r#{r}c#{c}"] = dists
            end

        end
    end
    allDists
end

def findAllKeys(f, sr, sc)
    foundKeys = []
    start = { :r => sr, :c => sc, :d => 0, :id => "r#{sr}c#{sc}", :doors => Set.new}
    seen = Set.new([start[:id]])
    queue = [start]
    until queue.empty?
        cur = queue.shift
        DIRS.each do |d|
            nr = cur[:r] + d.imag
            nc = cur[:c] + d.real
            nid = "r#{nr}c#{nc}"
            unless seen.include? nid
                seen << nid
                nd = cur[:doors].dup
                    foundKeys << {:r => nr, :c => nc, :k => f[nr][nc], :id => nid, :doors => cur[:doors]}  if f[nr][nc] =~ /[a-z]/
                    nd << f[nr][nc].downcase if f[nr][nc] =~ /[A-Z]/
                    queue << {:r => nr, :c => nc, :d => cur[:d]+1, :id=>nid, :doors => nd} if f[nr][nc] != ?#
            end
        end
    end
    foundKeys
end
sss = Time.now
dists = findAllDists(f)
p Time.now - sss
return
#p dists

p findAllKeys(f, bots[3][0], bots[3][1])

def makeBotId(bots, keys)
    bots.map{|x,y| "r#{x}c#{y}"}.join + keys.to_a.sort.join
end

botkeys = [
  findAllKeys(f, bots[0][0], bots[0][1]),
  findAllKeys(f, bots[1][0], bots[1][1]),
  findAllKeys(f, bots[2][0], bots[2][1]),
  findAllKeys(f, bots[3][0], bots[3][1])
]
p botkeys

p Time.now - sss

solved = false
start = { :b => bots.map(&:dup), :d => 0, :k => Set.new, :id =>  makeBotId(bots, Set.new)}
seen = {}
seen[start[:id]] = 0

queue = PrioQueue.new
queue.push start

until queue.empty? || solved
  cur = queue.pop
  next if seen[cur[:id]] < cur[:d]
  (0..3).each do |i|
    # puts "BOT = #{cur[:b][i].inspect}"
    botkeys[i].each do |key|
      # puts "KEY = #{key.inspect}"

      if !cur[:k].include? key[:k]
        # p "#{cur[:k]}   #{key[:k]}"
        #p "r#{cur[:b][i][0]}c#{cur[:b][i][1]}", "r#{key[:r]}c#{key[:c]}"
        # gets
        reachable = true
        key[:doors].each do |door|
          reachable = false unless cur[:k].include? door
        end
        if reachable

          #puts "============================"

          #puts "current bot: #{cur[:b][i]}  #{i}"
          #puts "current key: #{key}"
          #p ["r#{cur[:b][i][0]}c#{cur[:b][i][1]}"]


          dist = dists["r#{cur[:b][i][0]}c#{cur[:b][i][1]}"]["r#{key[:r]}c#{key[:c]}"]
          #p dist
          #gets

          nd = cur[:d] + dist
          nk = cur[:k].dup
          nk << key[:k]
          if nk.size == keys.size
            solution = nd
            solved = true
            puts solution
            break
          end
          nb = cur[:b].map(&:dup)
          nb[i][0] = key[:r]
          nb[i][1] = key[:c]
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


p Time.now - sss
