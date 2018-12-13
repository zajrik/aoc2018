from sequtils import toSeq
from strutils import join

let polymer = readFile("input.txt").string

# Return the opposite case of the given character
proc getOppositeCase(c: char): char =
    return char(int(c) xor 32)

# Process the given polymer, removing any reacting pairs
proc process(s: string): string
proc process(s1: string, s2: string): string

proc process(s: string): string =
    for i, c in s.pairs:
        if i == s.high: return s
        if c.getOppositeCase() == s[i + 1]:
            return process(s[0 .. i - 1], s[i + 2 .. ^1])

proc process(s1: string, s2: string): string =
    if s2.len == 0: return process(s1)
    if s1.len == 1 and s1[0].getOppositeCase() == s2[0]:
        return process(s2[1..^1])
        
    if s1[^1].getOppositeCase() == s2[0]:
        return process(s1[0 .. ^2], s2[1 .. ^1])

    return process(s1 & s2)

# Find solution
echo polymer.process().len
