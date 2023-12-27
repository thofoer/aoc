import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.regex.Pattern;

public class Tag19b {

    private final Blueprint bp;

    private final int maxOre;
    private final int maxClay;
    private final int maxObsidian;

    record Blueprint(int id, int oreOreCost, int clayOreCost, int obsOreCost, int obsClayCost, int geodeOreCost, int geodeObsCost){ }

    public Tag19b(Blueprint blueprint) {
        this.bp = blueprint;
        this.maxOre = Math.max(Math.max(bp.oreOreCost, bp.clayOreCost), bp.geodeOreCost);
        this.maxClay = bp.obsClayCost;
        this.maxObsidian = bp.geodeObsCost;
    }

    Map<Long, Integer> cache = new HashMap<>();

    private int findGeodeCount(int minLeft, int ore, int clay, int obsidian, int oreRobots, int clayRobots, int obsRobots, int geodeRobots) {

        long key = (long) minLeft << 35 | (long) ore << 30 | (long) clay << 25 | (long) obsidian << 20 | (long) oreRobots << 15 | (long) clayRobots << 10 | (long) obsRobots << 5 | geodeRobots;

        var k = cache.get(key);
        if (k!=null) {
            return k;
        }

        minLeft--;
        if (minLeft==0) {
            return 0;
        }
        var localBest = 0;

        var canBuildGeodeRobot = ore >= bp.geodeOreCost && obsidian >= bp.geodeObsCost;
        var canBuildOreRobot = ore >= bp.oreOreCost && oreRobots<maxOre && !canBuildGeodeRobot;
        var canBuildClayRobot = ore >= bp.clayOreCost && clayRobots<maxClay && !canBuildGeodeRobot;
        var canBuildObsRobot = ore >= bp.obsOreCost && clay >= bp.obsClayCost && obsRobots<maxObsidian && !canBuildGeodeRobot;

        var noWait = (canBuildOreRobot && canBuildClayRobot && (canBuildObsRobot || clayRobots == 0))
                   || canBuildGeodeRobot;

        if (canBuildOreRobot) {
            localBest = Math.max(
                    localBest,
                    findGeodeCount( minLeft, ore-bp.oreOreCost+oreRobots, clay+clayRobots, obsidian+obsRobots, oreRobots+1, clayRobots, obsRobots, geodeRobots)
            );
        }
        if (canBuildClayRobot) {
            localBest = Math.max(
                    localBest,
                    findGeodeCount( minLeft, ore-bp.clayOreCost+oreRobots, clay+clayRobots, obsidian+obsRobots, oreRobots, clayRobots+1, obsRobots, geodeRobots)
            );
        }
        if (canBuildObsRobot) {
            localBest = Math.max(
                    localBest,
                    findGeodeCount( minLeft, ore-bp.obsOreCost+oreRobots, clay-bp.obsClayCost+clayRobots, obsidian+obsRobots, oreRobots, clayRobots, obsRobots+1, geodeRobots)
            );
        }
        if (canBuildGeodeRobot) {
            localBest = Math.max(
                    localBest,
                    findGeodeCount( minLeft, ore-bp.geodeOreCost+oreRobots, clay+clayRobots, obsidian-bp.geodeObsCost+obsRobots, oreRobots, clayRobots, obsRobots, geodeRobots+1) + minLeft
            );
        }
        if (!noWait) {
            localBest = Math.max(
                    localBest,
                    findGeodeCount( minLeft, ore+oreRobots, clay+clayRobots, obsidian+obsRobots, oreRobots, clayRobots, obsRobots, geodeRobots)
            );
        }

        cache.put(key, localBest);
        return localBest;
    }


    private static List<Blueprint> parseInput(List<String> input) {
        var blueprints = new ArrayList<Blueprint>();
        var pattern = Pattern.compile("Blueprint (\\d+): Each ore robot costs (\\d+) ore. Each clay robot costs (\\d+) ore. Each obsidian robot costs (\\d+) ore and (\\d+) clay. Each geode robot costs (\\d+) ore and (\\d+) obsidian.");

        input.forEach(line -> {
            var matcher = pattern.matcher(line);
            while (matcher.find()) {
                var id = Integer.parseInt(matcher.group(1));
                var oreOreCost = Integer.parseInt(matcher.group(2));
                var clayOreCost = Integer.parseInt(matcher.group(3));
                var obsOreCost = Integer.parseInt(matcher.group(4));
                var obsClayCost = Integer.parseInt(matcher.group(5));
                var geodeOreCost = Integer.parseInt(matcher.group(6));
                var geodeObsCost = Integer.parseInt(matcher.group(7));
                blueprints.add(new Blueprint(id, oreOreCost, clayOreCost, obsOreCost, obsClayCost, geodeOreCost, geodeObsCost));
            }
        });
        return blueprints;
    }

    public int solution() {
        var solution =   findGeodeCount(32, 0, 0, 0, 1, 0, 0, 0);
        return solution;
    }


    public static void main(String[] args) throws Exception {
        var input = Files.readAllLines(Paths.get("19/input2.txt"));
        var blueprints = parseInput(input);

        var s = System.currentTimeMillis();
        var v1 = new Tag19b(blueprints.get(0)).solution();
        var v2 = new Tag19b(blueprints.get(1)).solution();
        var v3 = new Tag19b(blueprints.get(2)).solution();

        System.out.println(v1 * v2 * v3);

        System.out.println("Zeit: " + (System.currentTimeMillis()-s)/1000. +"s");
    }


}
