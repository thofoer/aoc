import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;

public class Tag17a {
    static int[] tileWidths = {4, 3, 3, 1, 2};
    static int[] tileHeights = {1, 3, 3, 4, 2};
    static char[][][] tiles = {
            {
                {'#', '#', '#', '#'}
            },
            {
                {'.', '#', '.'},
                {'#', '#', '#'},
                {'.', '#', '.'}
            },
            {
                {'#', '#', '#'},
                {'.', '.', '#'},
                {'.', '.', '#'}
            },
            {
                {'#'},
                {'#'},
                {'#'},
                {'#'}
            },
            {
                {'#', '#'},
                {'#', '#'}
            }
    };

    String wind;
    char[][] pit;

    int bottom = 0;
    int highest = 0;
    int tileIdx = 0;
    int step = 0;

    void dump() {
        for (int i=pit.length-1; i>=0; i--) {
            System.out.println(new String(pit[i]));
        }
        System.out.println();
    }

    boolean isWindLeft() {
        return wind.charAt(step++ % wind.length()) == '<';
    }

    boolean canPush(int tileIdx, int x, int y, boolean pushLeft) {
        if (pushLeft && x==0) {
            return false;
        }
        if (!pushLeft && x+tileWidths[tileIdx]==7) {
            return false;
        }
        return !isCollision(tileIdx, pushLeft ? x-1 : x+1, y);
    }

    boolean canFall(int tileIdx, int x, int y) {
        if (y-tileHeights[tileIdx]+1==bottom) {
            return false;
        }
        return !isCollision(tileIdx, x, y-1);
    }

    boolean isCollision(int tileIdx, int x, int y) {
        var tile = tiles[tileIdx];
        var tileHeight = tileHeights[tileIdx];

        for (int iy=0; iy<tileHeight; iy++){
            for (int ix=0; ix<tile[iy].length; ix++){
                if (tile[tileHeight-iy-1][ix]=='#' &&  pit[y-iy+bottom][x+ix-bottom] == '#') {
                    return true;
                }
            }
        }
        return false;
    }

    void updatePit(int tileIdx) {
        var newRows =  (3+tileHeights[(tileIdx+1)%5]) - (pit.length+bottom-highest);
        //println "newrows ="+newRows
        if (newRows > 0) {

            int length = pit.length;
            char[][] target = new char[length+newRows][7];
            for (int i = 0; i < length; i++) {
                System.arraycopy(pit[i], 0, target[i], 0, pit[i].length);
            }

            for (int i=0; i<newRows; i++) {
                target[length+i] = new char[]{'.', '.', '.', '.', '.', '.', '.'};
            }
            pit = target;
        }
    }

    void touchDown(int tileIdx, int x, int y) {
        var tile = tiles[tileIdx];
        var tileHeight = tileHeights[tileIdx];

        for (int iy=0; iy<tileHeight; iy++){
            for (int ix=0; ix<tile[iy].length; ix++){
                if (tile[tileHeight-iy-1][ix]=='#') {
                    pit[y-iy+bottom][x+ix-bottom] = '#';
                }
            }
        }
        if (y >= highest) {
            highest = y+1;
        }
        //  println "new highest "+highest
        updatePit(tileIdx);
    }

    void dropTile(int tileIdx) {
        var y = highest + 3 + tileHeights[tileIdx] -1;
        var x = 2;
        var falling = true;
        while(falling) {
            var pushLeft = isWindLeft();
            if (canPush(tileIdx, x, y, pushLeft)) {
                x += pushLeft ? -1 : 1;
            }
            if (canFall(tileIdx, x, y)) {
                y--;
            } else {
                touchDown(tileIdx, x, y);
                falling = false;
            }
        }
    }



    int findSolution(String wind) {
        this.wind = wind;

        pit = new char[4][7];
        for (int i=0; i<pit.length; i++) {
            Arrays.fill(pit[i], '.');
        }


        for (int i=0; i<2022; i++){
            dropTile(tileIdx++);
            tileIdx = tileIdx % 5;
        }
        return highest;
    }

    public static void main(String[] args) throws Exception {
        var wind = Files.readAllLines(Paths.get("17/input2.txt")).get(0);
        var s = System.currentTimeMillis();

        System.out.println(new Tag17a().findSolution(wind));

        System.out.println("Zeit: " + (System.currentTimeMillis()-s) +"ms");
    }
}
