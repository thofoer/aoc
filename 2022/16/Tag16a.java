import java.nio.file.Files;
import java.nio.file.Paths;

import java.util.*;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.regex.Pattern;
import static java.util.Collections.*;
import static java.util.stream.Collectors.*;

public class Tag16a {

    static Map<String, Integer> rates = new HashMap<>();
    static Map<String, Integer> posIds = new HashMap<>();
    static Map<String, Map<String, Integer>> distances = new HashMap<>();
    static Map<Long, Integer> visited = new HashMap<>();

    record Valve(String name, int rate, List<String> adjacent) { }

    record Path(String from, String to, int time) { }

    static private int process(String pos, int minLeft, long openValves) {
        long key = (long) (posIds.get(pos) << 20L) + ((long) minLeft << 15L) + openValves;
        if (visited.get(key)!=null) {
            return visited.get(key);
        }
        int localBest = 0;

        for (Map.Entry<String, Integer> next: distances.get(pos).entrySet()) {
            var neighbor = next.getKey();
            var bit = 1 << posIds.get(neighbor);
            if ((openValves & bit) == 0) {
                var remainderTime = minLeft - next.getValue() - 1;
                if (remainderTime > 0) {
                    localBest = Math.max(localBest, process(neighbor, remainderTime, openValves | bit) + rates.get(neighbor) * remainderTime);
                }
            }
        }
        visited.put(key, localBest);

        return localBest;
    }

    static Map<String, Valve> parseInput(List<String> input) {
        var valves = new HashMap<String, Valve>();
        var pattern = Pattern.compile("Valve (.+) has flow rate=(\\d+); tunnels? leads? to valves? (.+)");

        int[] z = new int[1];

        input.forEach(line -> {
            var matcher = pattern.matcher(line);
            while (matcher.find()) {
                var name = matcher.group(1);
                var rate = Integer.parseInt(matcher.group(2));
                var adjacent = Arrays.stream(matcher.group(3).split(",\\s*")).collect(toList());
                var valve = new Valve(name, rate, adjacent);
                valves.put(name, valve);
                if (rate>0) {
                    rates.put(name, rate);
                }
                if (rate>0 || name.equals("AA")) {
                    posIds.put(name, z[0]++);
                }
            }
        });

        return valves;
    }

    static void computeDistances(Map<String, Valve> valves) {
        Set<Path> paths = new HashSet<>();

        var nodes = valves.values().stream().filter(v -> v.rate > 0 || v.name.equals("AA")).map(Valve::name).collect(toList());

        for (int i = 0; i < nodes.size(); i++) {
            for (int j = 0; j < nodes.size(); j++) {
                if (i != j) {
                    var time = shortestPath(nodes.get(i), nodes.get(j), valves);
                    if (!nodes.get(j).equals("AA")) {
                        paths.add(new Path(nodes.get(i), nodes.get(j), time));
                    }
                    if (!nodes.get(i).equals("AA")) {
                        paths.add(new Path(nodes.get(j), nodes.get(i), time));
                    }
                }
            }
            paths.forEach(paths::add);
        }
        Map<String, List<Path>> pp =  paths.stream().collect(groupingBy(Path::from));

        pp.forEach( (k,y)-> {
            Map<String, Integer> m = new HashMap<>();

            y.forEach( p -> {
                m.put(p.to, p.time);
            });
            distances.put(k, m);
        });
    }

    private static int shortestPath(String start, String target, Map<String, Valve> graph) {
        record FindPath(List<String> nodes) {
            String last() {
                return nodes.get(nodes.size() - 1);
            }

            int length() {
                return nodes.size();
            }

            boolean contains(String node) {
                return nodes.contains(node);
            }

            FindPath goTo(String node) {
                var l = new ArrayList(nodes);
                l.add(node);
                return new FindPath(l);
            }
        }

        var queue = new PriorityQueue<FindPath>(Comparator.comparing(p -> p.nodes.size()));
        int best = Integer.MAX_VALUE;
        queue.add(new FindPath(List.of(start)));
        while (!queue.isEmpty()) {
            var next = queue.poll();
            if (next.length() < best) {
                if (next.last().equals(target)) {
                    best = next.length();
                } else {
                    graph.get(next.last()).adjacent.forEach(adj -> {
                        if (!next.contains(adj)) {
                            queue.add(next.goTo(adj));
                        }
                    });
                }
            }
        }
        return best - 1;
    }

    public static void main(String[] args) throws Exception {
        var input = Files.readAllLines(Paths.get("16/input2.txt"));
        var valves = parseInput(input);
        computeDistances(valves);

        System.out.println(process("AA", 30, 0L));
    }
}