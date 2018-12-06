from strutils import join, splitLines
from sequtils import toSeq

var inputs: seq[string] = readFile("input.txt").splitLines

# Return the number of characters different between two strings
proc compareTo(a: string, b: string): int =
    for i, _ in a.pairs:
        if a[i] != b[i]: result += 1

# Return the index of the first different character between two strings
proc getDiffIndex(a: string, b: string): int =
    for i, _ in a.pairs:
        if a[i] != b[i]: return i

block outer:
    for input in inputs:
        for compare in inputs:
            if input.compareTo(compare) == 1:
                var inputSeq: seq[char] = toSeq(input.items)
                inputSeq.delete(input.getDiffIndex(compare))
                echo inputSeq.join("")
                break outer
