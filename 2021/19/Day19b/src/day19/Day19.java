package day19;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;

public class Day19 {

    Beacon.Transformation compareScanners(Scanner s1, Scanner s2) {
        AtomicReference<Beacon.Transformation> result = new AtomicReference<>(null);
        Beacon.TR.forEach(tr -> {
            var rotated = s2.beacons.stream().map(b -> b.transform(tr)).collect(Collectors.toList());

        rotated.forEach( fix-> {

            s1.beacons.forEach(b -> {
                if (result.get()==null) {
                    var diff = b.diff(fix);

                    var moved = rotated.stream().map(bb -> bb.translate(diff)).collect(Collectors.toList());
                    var count = s1.intersectCount(moved);
                    if (count >= 12) {

                        System.out.println("-count->" + count + "   " + diff);
                        result.set(new Beacon.Transformation(tr, diff));
                    }
                }
            });
        });

        });
        return result.get();
    }

    public void process() {
ad
        List<Scanner> sc = Data.SCANNERS;
        int count = sc.size();

        var tf = new Beacon.Transformation[count][count];

        for (int n = 0; n < count; n++) {
            for (int m = 0; m < count; m++) {
                if (n != m) {

                    var res = compareScanners(sc.get(n), sc.get(m));
                    tf[n][m] = res;
                    if (res != null) {
                        System.out.println("## " + n + "->" + m);
                    }
                }
            }
        }

        System.out.println(Arrays.stream(tf).map(t->Arrays.toString(t)+"\n").collect(Collectors.toList()));

        var gesamt = new HashSet<Beacon>();
        gesamt.addAll(sc.get(0).beacons);
        for (int n=1; n<count; n++) {
            System.out.println("  SCANNER "+n);
            var path =  Helper.findPath(n,  tf);
            System.out.println("   path="+path);

            var last = path.get(0);
            var coords = sc.get(n).beacons;

            for (int p=1; p<path.size(); p++) {
                //System.out.println("   step=  "+last+"->"+path.get(p));
                var step = tf[path.get(p)][last];
                last = path.get(p);
                coords = coords.stream().map(u->u.transform(step)).collect(Collectors.toList());
                sc.get(n).origin = sc.get(n).origin.transform(step);
               // System.out.println(coords.stream().map(Beacon::toString).collect(Collectors.toList()));

            }
            gesamt.addAll(coords);
        };
        System.out.println(gesamt.size());

        System.out.println(Helper.maxDistance(sc));

    }


    public static void main(String... args) throws Exception {
        new Day19().process();
    }

}
