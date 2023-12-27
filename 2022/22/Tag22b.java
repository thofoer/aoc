import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;
import java.util.regex.Pattern;

public class Tag22b {

    static final int R = 0;
    static final int D = 1;
    static final int L = 2;
    static final int U = 3;

    static final int AHEAD = 0;
    static final int RIGHT = 1;
    static final int UTURN = 2;
    static final int LEFT = 3;

    static final char WALL = '#';
    static final char FREE = '.';
    static final char WRAP = ' ';

    String[] matrix;
    List<String> commands;
    int x;
    int y;
    int dir;

    Tag22b(String[] matrix, List<String> commands) {
        this.matrix = matrix;
        this.commands = commands;
        this.y = 1;
        this.x = matrix[1].indexOf(".");
        this.dir = R;
    }

    int process() {
        commands.forEach( cmd -> {
            if (cmd.equals("R") || cmd.equals("L")) {
                turn(cmd);
            }
            else {
                walk(Integer.parseInt(cmd));
            }
        });
        return 1000*y + 4*x + dir;
    }

    void turn(String direction) {
        dir += direction.equals("R") ? 1 : -1;
        if (dir==-1) {
            dir=3;
        }
        dir %= 4;
    }

    char pos(int x, int y) {
        return matrix[y].charAt(x);
    }

    int deltaX() {
        return switch(dir) {
            case R  -> 1;
            case L  -> -1;
            default -> 0;
        };
    }

    int deltaY() {
        return switch(dir) {
            case D -> 1;
            case U -> -1;
            default -> 0;
        };
    }

    void walk(int dist) {
        int dx = deltaX();
        int dy = deltaY();
        var collision = false;
        var z = dist;

        while (z>0 && !collision) {
            switch (pos(x + dx, y + dy)) {
                case FREE -> {
                    x += dx;
                    y += dy;
                    z--;
                }
                case WALL -> collision = true;
                case WRAP -> {
                    collision = !wrap();
                    if (!collision) {
                        z--;
                    }
                    dx = deltaX();
                    dy = deltaY();
                }
            }
        }
    }

    boolean wrap() {
        var wrapper = wrappers.stream().filter( w-> w.fromRange.contains(x,y) && w.head==dir).findFirst().orElseThrow();
        var newCoord = wrapper.wrap().apply(new Coord(x,y));
        if (pos(newCoord.x, newCoord.y) == FREE) {
            x = newCoord.x;
            y = newCoord.y;
            dir = (dir + wrapper.turn) % 4;
            return true;
        }
        return false;
    }

    record Coord(int x, int y) {
        Coord(String sx, String sy){
            this(Integer.parseInt(sx), Integer.parseInt(sy));
        }
    }

    record Range(Coord c1, Coord c2) {
       static Pattern pattern = Pattern.compile("(\\d+),(\\d+)-(\\d+),(\\d+)");

        boolean contains(int x, int y) {
            return c1.x <= x && x <= c2.x &&
                   c1.y <= y && y <= c2.y;
        }

        static Range of(String def) {
            var matcher = pattern.matcher(def);
            matcher.find();
            return new Range(new Coord(matcher.group(1),matcher.group(2)), new Coord(matcher.group(3),matcher.group(4)));
        }
    }

    record Wrapper(int head, Range fromRange, int turn, Function<Coord, Coord> wrap){ }

    static List<Wrapper> wrappers = List.of(
            new Wrapper(U, Range.of("51,1-100,1"),      RIGHT, (c)-> new Coord(1, c.x+100)),   // a1
            new Wrapper(L, Range.of("1,151-1,200"),     LEFT,  (c)-> new Coord(c.y-100, 1)),   // a2
            new Wrapper(U, Range.of("101,1-150,1"),     AHEAD, (c)-> new Coord(c.x-100, 200)), // b1
            new Wrapper(D, Range.of("1,200-50,200"),    AHEAD, (c)-> new Coord(c.x+100, 1)),   // b2
            new Wrapper(R, Range.of("150,1-150,50"),    UTURN, (c)-> new Coord(100, 151-c.y)), // c1
            new Wrapper(R, Range.of("100,101-100,150"), UTURN, (c)-> new Coord(150, 151-c.y)), // c2
            new Wrapper(D ,Range.of("101,50-150,50"),   RIGHT, (c)-> new Coord(100, c.x-50)),  // d1
            new Wrapper(R, Range.of("100,51-100,100"),  LEFT,  (c)-> new Coord(c.y+50, 50)),   // d2
            new Wrapper(L, Range.of("51,1-51,50"),      UTURN, (c)-> new Coord(1, 151-c.y)),   // e1
            new Wrapper(L, Range.of("1,101-1,150"),     UTURN, (c)-> new Coord(51, 151-c.y)),  // e2
            new Wrapper(L, Range.of("51,51-51,100"),    LEFT,  (c)-> new Coord( c.y-50, 101)), // f1
            new Wrapper(U, Range.of("1,101-50,101"),    RIGHT, (c)-> new Coord(51, c.x+50)),   // f2
            new Wrapper(D, Range.of("51,150-100,150"),  RIGHT, (c)-> new Coord(50, c.x+100)),  // g1
            new Wrapper(R, Range.of("50,150-50,200"),   LEFT,  (c)-> new Coord(c.y-100, 150))  // g2
    );

    static List<String> parseCommands(List<String> input) {
        var result = new ArrayList<String>();
        var pattern = Pattern.compile("(\\d+|R|L)");
        var matcher = pattern.matcher(input.get(input.size()-1));
        while(matcher.find()) {
            result.add(matcher.group(1));
        }
        return result;
    }

    static String[] parseMatrix(List<String> input)  {
        input.remove(input.size()-1);
        var maxLen = input.stream().mapToInt(String::length).max().getAsInt();
        var result = new String[input.size()+1];
        for (int i=0; i < result.length-1; i++) {
            result[i+1] = " "+input.get(i)+" ".repeat(maxLen-input.get(i).length()+1);
        }
        result[0] = " ".repeat(maxLen+2);
        result[result.length-1] = " ".repeat(maxLen+2);
        return result;
    }

    public static void main(String[] args) throws Exception {
        var input = Files.readAllLines(Paths.get("22/input2.txt"));
        var commands = parseCommands(input);
        var matrix = parseMatrix(input);
        var tag22a = new Tag22b(matrix, commands);

        System.out.println(tag22a.process());
    }
}
