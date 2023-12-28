package day19;

import java.util.List;
import java.util.Objects;

public class Beacon {

    public int x;
    public int y;
    public int z;

    public Beacon(int x, int y, int z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public Beacon transform(Transformer t) {
        return t.transform(this);
    }

    public Beacon transform(Transformation t) {
        return this.transform(t.rot).translate(t.delta);
    }

    public Beacon translate(Beacon o) {
        return new Beacon(x+o.x, y+o.y, z+o.z);
    }

    public Beacon diff(Beacon o) {
        return new Beacon(x-o.x, y-o.y, z-o.z);
    }

    @Override
    public String toString() {
        return "(" + x + "," + y + "," + z + ")";
    }

    @Override
    public int hashCode() {
        return Objects.hash(x, y, z);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Beacon other = (Beacon) obj;
        return x == other.x && y == other.y && z == other.z;
    }

    static class Transformation {
        public Transformer rot;
        public Beacon delta;

        public Transformation(Transformer rot, Beacon delta) {
            this.rot=rot;
            this.delta=delta;
        }

        public String toString() {
            return " "+delta;
        }
    }

    interface Transformer {
        Beacon transform(Beacon b);
    }

    static List<Transformer> TR = List.of(

            (b) -> new Beacon(b.x, b.y, b.z),
            (b) -> new Beacon(b.x, b.z, -b.y),
            (b) -> new Beacon(b.x, -b.y, -b.z),
            (b) -> new Beacon(b.x, -b.z, b.y),
            (b) -> new Beacon(-b.x, -b.y, b.z),
            (b) -> new Beacon(-b.x, b.z, b.y),
            (b) -> new Beacon(-b.x, b.y, -b.z),
            (b) -> new Beacon(-b.x, -b.z, -b.y),
            (b) -> new Beacon(b.y, -b.x, b.z),
            (b) -> new Beacon(b.y, b.z, b.x),
            (b) -> new Beacon(b.y, b.x, -b.z),
            (b) -> new Beacon(b.y, -b.z, -b.x),
            (b) -> new Beacon(-b.y, b.x, b.z),
            (b) -> new Beacon(-b.y, -b.z, b.x),
            (b) -> new Beacon(-b.y, -b.x, -b.z),
            (b) -> new Beacon(-b.y, b.z, -b.x),
            (b) -> new Beacon(b.z, b.y, -b.x),
            (b) -> new Beacon(b.z, b.x, b.y),
            (b) -> new Beacon(b.z, -b.y, b.x),
            (b) -> new Beacon(b.z, -b.x, -b.y),
            (b) -> new Beacon(-b.z, b.y, b.x),
            (b) -> new Beacon(-b.z, -b.x, b.y),
            (b) -> new Beacon(-b.z, -b.y, -b.x),
            (b) -> new Beacon(-b.z, b.x, -b.y)

            /*
            (b) -> new Beacon(b.x, b.y, b.z),    // (1,2,3)
            (b) -> new Beacon(b.x, b.z, -b.y),   // (1,3,-2)
            (b) -> new Beacon(b.x, -b.y, -b.z),  // (1,-2,-3)
            (b) -> new Beacon(b.x, -b.z, b.y),   // (1,-3,2)
            (b) -> new Beacon(b.y, -b.x, b.z),   // (2,-1,3)
            (b) -> new Beacon(-b.y, b.x, b.z),   // (-2,1,3)
            (b) -> new Beacon(-b.z, b.y, b.x),   // (-3,2,1)
            (b) -> new Beacon(b.y, b.z, b.x),    // (2,3,1)
            (b) -> new Beacon(b.z, -b.y, b.x),   // (3,-2,1)
            (b) -> new Beacon(-b.y, -b.z, b.x),  // (-2,-3,1)
            (b) -> new Beacon(-b.z, -b.x, b.y),  // (-3,-1,2)
            (b) -> new Beacon(-b.z, b.x, -b.y),  // (-3,1,-2)
            (b) -> new Beacon(-b.x, b.y, -b.z),  // (-1,2,-3)
            (b) -> new Beacon(-b.x, b.z, b.y),   // (-1,3,2)
            (b) -> new Beacon(-b.x, -b.y, b.z),  // (-1,-2,3)
            (b) -> new Beacon(-b.x, -b.z, -b.y), // (-1,-3,-2)
            (b) -> new Beacon(-b.y, -b.x, -b.z), // (-2,-1,-3)
            (b) -> new Beacon(b.y, b.x, -b.z),   // (2,1,-3)
            (b) -> new Beacon(b.z, b.y, -b.x),   // (3,2,-1)
            (b) -> new Beacon(-b.y, b.z, -b.x),  // (-2,3,-1)
            (b) -> new Beacon(-b.z, -b.y, -b.x), // (-3,-2,-1)
            (b) -> new Beacon(b.y, -b.z, -b.x),  // (2,-3,-1)
            (b) -> new Beacon(b.z, -b.x, -b.y),  // (3,-1,-2)
            (b) -> new Beacon(b.z, b.x, b.y)     // (3,1,2)

             */
            );

}
