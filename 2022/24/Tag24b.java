import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

public class Tag24b {

    List<Blizzard> blizzards;
    static int width;
    static int height;
    static int cycle;

    Tag24b(List<Blizzard> blizzards) {
        this.blizzards = blizzards;
    }

     int findSolution(){
        var entry = new Coord(1,0);
        var exit = new Coord(width, height+1);

        var l1 = findPath(0, entry, exit);
        var l2 = findPath(l1, exit, entry);
        var l3 = findPath(l1+l2, entry, exit);
        return l1+l2+l3;
    }

    int findPath(int startTime, Coord start, Coord target) {

        var time = new int[]{startTime};
        Set<Coord> places = new HashSet<>();
        places.add(start);

        while(!places.contains(target)) {
            time[0]++;
            places = places.stream().map( c -> findForPos(time[0], c)).flatMap(Collection::stream).collect(Collectors.toSet());
        }
        return time[0]-startTime;
    }


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
        var input = Files.readAllLines(Paths.get("24/input2.txt"));
        var blizz = parseInput(input );

        width = input.get(0).length()-2;
        height = input.size()-2;
        cycle = kgV(width, height);

        var tag24b = new Tag24b(blizz);
        System.out.println(tag24b.findSolution());
    }
}
