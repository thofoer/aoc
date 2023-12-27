import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

import static java.util.stream.Collectors.groupingBy;

public class Tag23b {

    static final int N = 0;
    static final int S = 1;
    static final int W = 2;
    static final int E = 3;

    static final Map<Integer, int[]> LOOKUP_X = Map.of(
            N, new int[]{ -1,  0,  1},
            S, new int[]{ -1,  0,  1},
            W, new int[]{ -1, -1, -1},
            E, new int[]{  1,  1,  1}
    );

    static final Map<Integer, int[]> LOOKUP_Y =Map.of(
            N, new int[]{-1, -1, -1},
            S, new int[]{ 1,  1,  1},
            W, new int[]{-1,  0,  1},
            E, new int[]{-1,  0,  1}
    );

    Map<Coord, Elf> elves;

    int firstDirection = N;

    Tag23b(Map<Coord, Elf> elves) {
        this.elves = elves;
    }

    Coord getDest(Elf elf, int dir) {
        var p1 = elf.pos.translate(LOOKUP_X.get(dir)[0], LOOKUP_Y.get(dir)[0]);
        var p2 = elf.pos.translate(LOOKUP_X.get(dir)[1], LOOKUP_Y.get(dir)[1]);
        var p3 = elf.pos.translate(LOOKUP_X.get(dir)[2], LOOKUP_Y.get(dir)[2]);

        return isFree(p1) && isFree(p2) && isFree(p3) ? p2 : null;
    }

    boolean standsFree(Elf elf) {
        return List.of(
                elf.pos.translate(0, 1),
                elf.pos.translate(0, -1),
                elf.pos.translate(1, 1),
                elf.pos.translate(1, 0),
                elf.pos.translate(1, -1),
                elf.pos.translate(-1, 1),
                elf.pos.translate(-1, 0),
                elf.pos.translate(-1, -1)
        )
        .stream()
        .allMatch(this::isFree);
    }

    int findSolution() {
        var z = 1;
        while(doStep()) {
            z++;
        }
        return z;
    }

    boolean doStep() {
        findDestinations();
        testCollisions();
        firstDirection = (firstDirection+1) % 4;
        return moveElves();
    }

    void findDestinations() {
        elves.values().forEach(this::findDestination);
    }

    void findDestination(Elf elf) {
        if (!standsFree(elf)) {
            for (int z = 0; z < 10; z++) {
                var dest = getDest(elf, (firstDirection + z) % 4);
                if (dest != null) {
                    elf.dest = dest;
                    return;
                }
            }
        }
    }

    void testCollisions() {
        Map<Coord, Long> dests = elves
                .values()
                .stream()
                .filter(elf->elf.dest!=null)
                .map(elf->elf.dest)
                .collect(groupingBy(Function.identity(), Collectors.counting()));

        elves.values().forEach( elf -> {
            var c = dests.get(elf.dest);
            if ( c!=null && c > 1) {
                elf.dest = null;
            }
        });
    }

    boolean moveElves() {
        var moved = new boolean[]{false};
        elves.values().forEach( elf -> {
            if (elf.dest!=null) {
               // System.out.println("move "+elf.pos+"->"+elf.dest);
                elf.pos = elf.dest;
                elf.dest = null;
                moved[0] = true;
            }
        });
        elves = elves.values().stream().collect(Collectors.toMap(e->e.pos, Function.identity()));
        return moved[0];
    }

    boolean isFree(Coord c) {
        return !elves.containsKey(c);
    }

    record Coord(int x, int y) {
        public String toString() {
            return "("+x+","+y+")";
        }
        Coord translate(int dx, int dy) {
            return new Coord(x+dx, y+dy);
        }
    }

    static class Elf {
        Coord pos;
        Coord dest;

        Elf(int x, int y) {
            this.pos = new Coord(x,y);
        }
        Elf(Coord pos) {
            this.pos = pos;
        }
        public String toString() {
            return pos.toString();
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Elf elf = (Elf) o;
            return pos.equals(elf.pos);
        }

        @Override
        public int hashCode() {
            return Objects.hash(pos);
        }
    }

    static Set<Coord> parseInput(List<String> input) {
        var result = new HashSet<Coord>();
        for(int y=0; y<input.size(); y++) {
            var line = input.get(y);
            for (int x=0; x<line.length(); x++) {
                if (line.charAt(x)=='#') {
                    result.add(new Coord(x,y));
                }
            }
        }
        return result;
    }

    public static void main(String[] args) throws Exception {
        var input = Files.readAllLines(Paths.get("23/input2.txt"));
        var coords = parseInput(input);
        var elfs = coords.stream().collect(Collectors.toMap( Function.identity(), Elf::new ));
        var tag23a = new Tag23b(elfs);
        System.out.println(tag23a.findSolution());
    }
}
