import java.util.*;
import java.util.function.Consumer;

class Burrow {

    static Map<Character, Integer> ROOMS = Map.of('a', 0, 'b', 1, 'c', 2, 'd', 3);
    static Map<Integer, Character> INV_ROOMS = Map.of(0, 'a', 1, 'b', 2, 'c', 3, 'd');
    static Map<Character, int[]> EXITS = Map.of('a', new int[]{1, 3}, 'b', new int[]{3, 5}, 'c', new int[]{5, 7}, 'd', new int[]{7, 9});
    static Map<Character, Integer> ENERGY = Map.of('a', 1, 'b', 10, 'c', 100, 'd', 1000);

    static int MAX_HALLWAY = 10;
    static int MAX_ROOM = 3;

    char[][] r = {
            new char[]{'.', '.', '.', '.'},
            new char[]{'.', '.', '.', '.'},
            new char[]{'.', '.', '.', '.'},
            new char[]{'.', '.', '.', '.'}};                // Räume(a,b,c,d): Index 0=oben, Index 1=unten

    char[] h = {'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'};   // Hallway von links nach rechts
    int energy = 0;

    Burrow(String a, String b, String c, String d) {
        this(new char[][]{a.toCharArray(), b.toCharArray(), c.toCharArray(), d.toCharArray()});
    }

    Burrow(char[][] p) {
        r = p;
    }

    Burrow(Burrow o) {
        r[0] = o.r[0].clone();
        r[1] = o.r[1].clone();
        r[2] = o.r[2].clone();
        r[3] = o.r[3].clone();
        h = o.h.clone();
        energy = o.energy;
    }

    boolean isFinished() {
        return
                r[0][0] == 'a' && r[0][1] == 'a' && r[0][2] == 'a' && r[0][3] == 'a' &&
                        r[1][0] == 'b' && r[1][1] == 'b' && r[1][2] == 'b' && r[1][3] == 'b' &&
                        r[2][0] == 'c' && r[2][1] == 'c' && r[2][2] == 'c' && r[2][3] == 'c' &&
                        r[3][0] == 'd' && r[3][1] == 'd' && r[3][2] == 'd' && r[3][3] == 'd';
    }

    List<Burrow> possibleMoves() {
        var res = new ArrayList<Burrow>();

        for (int i = 0; i < h.length; i++) {
            if (h[i] != '.') {
                res.addAll(hallwayMoves(i, h[i]));
            }
        }
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j <= MAX_ROOM; j++) {
                if (r[i][j] != '.') {
                    res.addAll(roomMoves(i, j, r[i][j]));
                    break;
                }
            }
        }
        return res;
    }

    Burrow create(Consumer<Burrow> action) {
        var res = new Burrow(this);
        action.accept(res);
        return res;
    }

    List<Burrow> roomMoves(int roomIndex, int roomPos, char p) {
        var res = new ArrayList<Burrow>();

        if (p == INV_ROOMS.get(roomIndex)) {
            boolean ok = true;  // drunterliegende auch zu hause
            for (int i = roomPos + 1; ok && i <= MAX_ROOM; i++) {
                if (r[roomIndex][i] != p) {
                    ok = false;
                }
            }
            if (ok) {
                return res;
            }
        }
        for (int exit = 0; exit <= 1; exit++) {
            if (h[EXITS.get(INV_ROOMS.get(roomIndex))[exit]] == '.') {
                int finalExit = exit;
                res.add(create(b -> {
                    b.h[EXITS.get(INV_ROOMS.get(roomIndex))[finalExit]] = r[roomIndex][roomPos];
                    b.r[roomIndex][roomPos] = '.';
                    b.energy += (roomPos + 2) * ENERGY.get(r[roomIndex][roomPos]);
                }));
            }
        }
        return res;
    }

    List<Burrow> hallwayMoves(int i, char p) {
        var res = new ArrayList<Burrow>();
        int[] room = EXITS.get(p);
        if (i == room[0] || i == room[1]) { // in raum gehen wenn möglich
            if (isEnteringRoomPossible(p)) {
                int dest = 0;
                if (r[ROOMS.get(p)][1] == '.') {
                    dest++;
                    if (r[ROOMS.get(p)][2] == '.') {
                        dest++;
                        if (r[ROOMS.get(p)][3] == '.') {
                            dest++;
                        }
                    }
                }
                int finalDest = dest;
                res.add(create(b -> {
                    b.h[i] = '.';
                    b.r[ROOMS.get(p)][finalDest] = p;
                    b.energy += (finalDest + 2) * ENERGY.get(p);
                }));
                return res;
            }
        }

        if (i == 0 || i == 1) {  // von pos 0 nach 1 und 1 nach 0
            if (h[1 - i] == '.') {
                res.add(create(b -> {
                    b.h[i] = '.';
                    b.h[1 - i] = p;
                    b.energy += ENERGY.get(p);
                }));
            }
            return res;
        }
        if (i == MAX_HALLWAY || i == MAX_HALLWAY - 1) {  // von pos 10 nach 9 und 9 nach 10
            if (h[i == MAX_HALLWAY ? MAX_HALLWAY - 1 : MAX_HALLWAY] == '.') {
                res.add(create(b -> {
                    b.h[i] = '.';
                    b.h[i == MAX_HALLWAY ? MAX_HALLWAY - 1 : MAX_HALLWAY] = p;
                    b.energy += ENERGY.get(p);
                }));
            }
        }

        for (int e : new int[]{0, 1}) {
            for (char c : new char[]{'a', 'b', 'c', 'd'}) {
                if (i == EXITS.get(c)[e]) {
                    if (h[EXITS.get(c)[1 - e]] == '.') {
                        res.add(create(b -> {
                            b.h[i] = '.';
                            b.h[EXITS.get(c)[1 - e]] = p;
                            b.energy += 2 * ENERGY.get(p);
                        }));
                    }
                }
            }
        }
        return res;
    }

    boolean isEnteringRoomPossible(char p) {
        return r[ROOMS.get(p)][0] == '.'
                && (r[ROOMS.get(p)][1] == '.' || r[ROOMS.get(p)][1] == p)
                && (r[ROOMS.get(p)][2] == '.' || r[ROOMS.get(p)][2] == p)
                && (r[ROOMS.get(p)][3] == '.' || r[ROOMS.get(p)][3] == p);
    }

    public String toString() {
        return String.format("#############\n#%s#\n###%s#%s#%s#%s###\n  #%s#%s#%s#%s#\n  #%s#%s#%s#%s#\n  #%s#%s#%s#%s#\n  #########        %d\n",
                new String(h),
                r[0][0], r[1][0], r[2][0], r[3][0],
                r[0][1], r[1][1], r[2][1], r[3][1],
                r[0][2], r[1][2], r[2][2], r[3][2],
                r[0][3], r[1][3], r[2][3], r[3][3],
                energy
        );
    }

    public int getEnergy() {
        return energy;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Burrow burrow = (Burrow) o;
        return Arrays.equals(r[0], burrow.r[0])
                && Arrays.equals(r[1], burrow.r[1])
                && Arrays.equals(r[2], burrow.r[2])
                && Arrays.equals(r[3], burrow.r[3])
                && Arrays.equals(h, burrow.h);
    }

    @Override
    public int hashCode() {
        int result = Arrays.hashCode(r[0]);
        result = 31 * result + Arrays.hashCode(r[1]);
        result = 17 * result + Arrays.hashCode(r[2]);
        result = 41 * result + Arrays.hashCode(r[3]);
        result = 19 * result + Arrays.hashCode(h);
        return result;
    }
}
public class Day23 {

    static int minEnergy;
    static Map<Burrow, Integer> visited;

    static int search(Burrow burrow) {
        minEnergy = Integer.MAX_VALUE;
        visited = new HashMap<>();

        PriorityQueue<Burrow> queue = new PriorityQueue<>(Comparator.comparing(Burrow::getEnergy));
        queue.add(burrow);

        while (!queue.isEmpty()) {
            Burrow b = queue.poll();
            if (b.energy>=minEnergy) {
                continue;
            }
            if (b.isFinished()) {
                minEnergy = Math.min(b.energy, minEnergy);
                continue;
            }
            for (Burrow next : b.possibleMoves()) {
                var oldValue = visited.get(next);
                if (oldValue==null || oldValue>next.energy) {
                    visited.put(next, next.energy);
                    queue.add(next);
                }
            }
        }
        return minEnergy;
    }

    public static void main(String... args){
        System.out.println("Part 1: "+search(new Burrow("bcaa", "adbb", "bdcc", "cadd")));
        System.out.println("Part 2: "+search(new Burrow("bddc", "acbd", "bbad", "caca")));
    }
}
