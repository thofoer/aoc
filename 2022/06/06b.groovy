def input = new File('input2.txt').text
def runLength = 14

for(int i = 0; i < input.length()-runLength; i++) {
    if (input[(i..<(i + runLength))].toSet().size() == runLength) {
        println i + runLength
        break;
    }
}