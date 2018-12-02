from strutils import join
from sequtils import toSeq

var
    file: File
    inputs: seq[string] = @[]

discard open(file, "input.txt")

while true:
    if endOfFile(file): break
    inputs.add(readLine(file))

close(file)

# Return the number of characters different between two strings
proc compareTo(a: string, b: string): int =
    for i, _ in a.pairs:
        if a[i] != b[i]: result += 1

# Return the index of the first different character between two strings
proc getDiffIndex(a: string, b: string): int =
    for i, _ in a.pairs:
        if a[i] != b[i]: return i

for input in inputs:
    for compare in inputs:
        let diff: int = input.compareTo(compare)
        if diff == 0: continue
        if diff == 1:
            var inputSeq: seq[char] = toSeq(input.items)
            inputSeq.delete(input.getDiffIndex(compare))
            echo inputSeq.join("")
