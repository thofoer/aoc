package day19;

import java.util.List;

public class Scanner {

    public Beacon origin = new Beacon(0,0,0);

    public List<Beacon> beacons;

    public Scanner(List<Beacon> beacons) {
        this.beacons=beacons;
    }

    public int intersectCount(List<Beacon> o) {
        return (int)beacons.stream().filter(o::contains).count();
    }
}
