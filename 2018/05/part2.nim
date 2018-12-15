import threadpool, sugar
from strutils import multiReplace
from sequtils import any
from os import sleep

let polymer: string = readFile("input.txt").string

var
    shortest: int = high(int)
    threads: array[26, FlowVar[int]]

# Return the opposite case of the given character
proc getOppositeCase(c: char): char =
    return char(int(c) xor 32)

# Remove the given character, upper and lowercase, from the given string
# and return the new string
proc removeLetter(s: string, c: char): string =
    return s.multiReplace(($c, ""), ($(c.getOppositeCase()), ""))

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
        return process(s1[0..^2], s2[1..^1])

    return process(s1 & s2)

# Process the given polymer with the given char removed, returning the length
proc run(p: string, c: char): int {.thread.} =
    return p.removeLetter(c).process().len

# Create threads to process all 26 polymers
for i in 0..25:
    threads[i] = spawn run(polymer, char(int('a') + i))

# Wait for threads to finish
while threads.any(a => not a.isReady): sleep(1)

# Find solution
for val in threads:
    if ^val < shortest: shortest = ^val

echo shortest
