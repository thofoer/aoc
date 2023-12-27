import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class Tag22a {

    static final int R = 0;
    static final int D = 1;
    static final int L = 2;
    static final int U = 3;

    static final char WALL = '#';
    static final char FREE = '.';
    static final char WRAP = ' ';

    String[] matrix;
    List<String> commands;
    int x;
    int y;
    int dir;

    Tag22a(String[] matrix,  List<String> commands) {
        this.matrix = matrix;
        this.commands = commands;
        this.y = 1;
        this.x = matrix[1].indexOf(".");
        this.dir = R;
        for(int i=0; i< matrix.length; i++){
            System.out.println(matrix[i].replaceAll(" ", "~"));
        }
    }

    int process() {
        commands.forEach( cmd -> {
            if (cmd.equals("R") || cmd.equals("L")) {
                turn(cmd);
            }
            else {
                int dist = Integer.parseInt(cmd);
                walk(dist);
            }
           // System.out.println("("+x+","+y+")");
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

    void walk(int dist) {
        int dx = switch(dir) {
            case R  -> 1;
            case L  -> -1;
            default -> 0;
        };
        int dy = switch(dir) {
            case D  -> 1;
            case U  -> -1;
            default -> 0;
        };
        var collision = false;
        var z = dist;

        while (z>0 && !collision) {
            switch(pos(x+dx, y+dy)) {
                case FREE:
                    x+=dx; y+=dy;
                    z--;
                    break;
                case WALL:
                    collision = true;
                    break;
                case WRAP:
                    if (dy==0) { // horizontal wrap
                        int wrapX = wrap(true);
                        if (wrapX==-1) {
                            collision = true;
                        }
                        else {
                            x = wrapX;
                        }
                    }
                    else {
                        int wrapY = wrap(false);
                        if (wrapY==-1) {
                            collision = true;
                        }
                        else {
                            y = wrapY;
                        }
                    }
            }
        }
    }

    int wrap(boolean horizontal) {
        int d = (dir + 2) % 4;
        int delta = (d==U||d==L) ? -1 : 1;
        int z = 1;
        if (horizontal) {
            while(pos(x+z*delta, y)!=WRAP) z++;
            return pos(x+(z-1)*delta, y)==FREE ? x+z*delta : -1;
        }
        else {
            while(pos(x, y+z*delta)!=WRAP) z++;
            return pos(x,y+(z-1)*delta)==FREE ? y+z*delta : -1;
        }
    }

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
        var tag22a = new Tag22a(matrix, commands);
        System.out.println(tag22a.process());

    }
}
