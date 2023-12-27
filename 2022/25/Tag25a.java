import java.nio.file.Files;
import java.nio.file.Paths;

public class Tag25a {

    static long snafuToDec(String s) {
        long res = 0;
        for (int i=0; i<s.length(); i++) {
            res *= 5;
            switch(s.charAt(i)) {
                case '2' -> res +=2;
                case '1' -> res +=1;
                case '-' -> res -=1;
                case '=' -> res -=2;
            }
        }
        return res;
    }

    static String decToSnafu(long n, long c) {
        if (n==0) {
            return "0";
        }

        long f = (long)Math.pow(5,c);

        if (f>Math.abs(n)+2L*Math.pow(5,c-1)) {
            return "0"+decToSnafu(n, c-1);
        }

        int  val = n > 0 ? 1 : -1;

        if (Math.abs(n - 2 * f * val) < Math.abs(n - f * val)) {
            return  (val > 0 ? "2" : "=") + decToSnafu(n - 2 * f * val, c - 1);
        }
        else {
            return  (val > 0 ? "1" : "-") + decToSnafu(n - f * val, c - 1);
        }
    }

    public static void main(String[] args) throws Exception {
        var input = Files.readAllLines(Paths.get("25/input2.txt"));

        var sum = input.stream().mapToLong(Tag25a::snafuToDec).sum();

        var c = (int)Math.round((Math.log(sum) / Math.log(5)));

        System.out.println(decToSnafu(sum, c));
    }
}
