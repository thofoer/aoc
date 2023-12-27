import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class Tag21b {

    static Pattern valuePattern = Pattern.compile("(.*): (\\d+)");
    static Pattern termPattern = Pattern.compile("(.*): (.*) (.) (.*)");

    static Map<String, Monkey> monkeys;

    record Monkey(String name, String leftTerm, String operator, String rightTerm, Long value) {

        static Monkey create(String line) {

            var matcher = valuePattern.matcher(line);
            if (matcher.find()) {
                return new Monkey(matcher.group(1), null, null, null, Long.parseLong(matcher.group(2)));
            }
            matcher = termPattern.matcher(line);
            matcher.find();
            return new Monkey(matcher.group(1), matcher.group(2), matcher.group(3), matcher.group(4), null);
        }

        List<String> children() {
            var res = new ArrayList<String>();
            if (leftTerm!=null) {
                res.add(leftTerm);
                res.add(rightTerm);
                res.addAll(getLeft().children());
                res.addAll(getRight().children());
            }
            return res;
        }

        Monkey getLeft() {
            return monkeys.get(leftTerm);
        }

        Monkey getRight() {
            return monkeys.get(rightTerm);
        }

        boolean isHumnLeft() {
            return leftTerm.equals("humn") || getLeft().children().contains("humn");
        }

        long getValue() {
            if (value != null) {
                return value;
            } else {
                var l = getLeft().getValue();
                var r = getRight().getValue();
                return switch (operator) {
                    case "+" -> l + r;
                    case "-" -> l - r;
                    case "*" -> l * r;
                    case "/" -> l / r;
                    default -> throw new Error();
                };
            }
        }

        long findSolution(long desired) {
            if (name.equals("humn")) {
                return desired;
            }
            var isLeft = isHumnLeft();
            var searchMonkey = isLeft ? getLeft() : getRight();
            var valueMonkey = isLeft ? getRight() : getLeft();
            var fixedValue = valueMonkey.getValue();

            return switch (operator) {
                case "+" -> searchMonkey.findSolution(desired - fixedValue);
                case "-" -> searchMonkey.findSolution(isLeft ? desired + fixedValue : fixedValue - desired);
                case "*" -> searchMonkey.findSolution(desired / fixedValue);
                case "/" -> searchMonkey.findSolution(isLeft ? desired * fixedValue : fixedValue / desired);
                default -> throw new Error();
            };
        }
    }

    public static void main(String[] args) throws Exception {
        var input = Files.readAllLines(Paths.get("21/input2.txt"));
        monkeys = input.stream().map(Monkey::create).collect(Collectors.toMap(Monkey::name, Function.identity()));

        var root = monkeys.get("root");
        var isLeft = root.isHumnLeft();
        var searchMonkey = isLeft ? root.getLeft() : root.getRight();
        var valueMonkey = isLeft ? root.getRight() : root.getLeft();

        var desired = valueMonkey.getValue();
        var solution = searchMonkey.findSolution(desired);

        System.out.println(solution);
    }
}
