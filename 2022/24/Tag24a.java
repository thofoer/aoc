import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

public class Tag24a {

    List<Blizzard> blizzards;
    static int width;
    static int height;

    Tag24a(List<Blizzard> blizzards) {
        this.blizzards = blizzards;
    }

    int findSolution(){
        var cycle = kgV(width, height);
        var target = new Coord(1,0);
        var start = new Coord(width, height+1);
        var best = Integer.MAX_VALUE;
        var startTime = 18;

        var queue = new ArrayDeque<State>();

        queue.add(new State(startTime, start, start.toString()));

        var cache = new HashSet<Integer>();

        while(!queue.isEmpty()) {
            var next = queue.removeLast();
           // System.out.println(next);
            if (next.position.equals(target)) {
                if (next.time < best) {
                    best  = next.time;
                }
            }
            else if (next.time < best){

                var key = next.position.x << 24 | next.position.y << 16 | (next.time % cycle);
                if (cache.contains(key)) {
                    continue;
                }
                cache.add(key);

                var adj = findForPos(next.time+1, next.position);

                    adj.forEach( nextPos -> {
                        queue.push(new State(next.time+1, nextPos, next.path+" "+nextPos));
                    });

            }
        }
        return best-startTime;
    }

    record State(int time, Coord position, String path) { }

    Set<Coord> findForPos(int time, Coord pos) {
        var coords = List.of(
                new Coord(pos.x-1, pos.y),
                new Coord(pos.x+1, pos.y),
                new Coord(pos.x, pos.y),
                new Coord(pos.x, pos.y-1),
                new Coord(pos.x, pos.y+1)
        );
        var blizzCoord = blizzards
                .stream()
                .map(b -> b.getPosAt(time))
                .filter(coords::contains)
                .collect(Collectors.toSet());
        return coords
                .stream()
                .filter( c-> !blizzCoord.contains(c))
                .filter( c -> (c.x > 0 && c.y > 0 && c.x <=width && c.y <= height) || (c.x==width && c.y==height+1) || (c.x==1 && c.y==0))
                .collect(Collectors.toSet());
    }

    record Blizzard(int line, int start, char direction) {

        Coord getPosAt(int time) {
            var vertical = direction=='^' || direction=='v';
            var f = direction=='^' || direction=='<' ? -1 : 1;
            var m = vertical ? height : width;
            var variablePos = mod(start-1 + f*time, m) +1;
            var x = vertical ? line : variablePos;
            var y = vertical ? variablePos : line;
            return new Coord(x, y);
        }
    }

    record Coord(int x, int y) {
        public String toString() {
            return "("+x+","+y+")";
        }
    }

    static int mod(int a, int b) {
        var r = a % b;
        return r<0 ? (b+r) : r;
    }

    static List<Blizzard> parseInput(List<String> input) {
        var result = new ArrayList<Blizzard>();
        for(int y=0; y<input.size(); y++) {
            var line = input.get(y);
            for (int x=0; x<line.length(); x++) {
                char c = line.charAt(x);
                switch(c) {
                    case '>', '<' -> result.add(new Blizzard(y, x, c));
                    case 'v', '^' -> result.add(new Blizzard(x, y, c));
                }
            }
        }
        return result;
    }

    static int ggT(int a, int b) {
        return (a == b | b == 0) ? a : ggT(b, a % b);
    }

    static int kgV(int a, int b) {
        return a * (b / ggT(a, b));
    }

    public static void main(String[] args) throws Exception {
        var input = Files.readAllLines(Paths.get("24/input1.txt"));
        var blizz = parseInput(input );

        width = input.get(0).length()-2;
        height = input.size()-2;
        var tag24a = new Tag24a(blizz);
        System.out.println(tag24a.findSolution());
    }
}
