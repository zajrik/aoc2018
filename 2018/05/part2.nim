from sequtils import toSeq
from strutils import join, multiReplace

var
    input: seq[char] = toSeq(readFile("input.txt").string.items)
    polymer: seq[char] = @[]
    previous: seq[char] = @[]
    shortest: int = high(int)

# Return the opposite case of the given character
proc getOppositeCase(c: char): char =
    return char(int(c) xor 32)

# Remove the given character, upper and lowercase, from the given char sequence
# and return the new sequence
proc removeLetter(s: seq[char], c: char): seq[char] =
    return toSeq(s
        .join("")
        .multiReplace(($c, ""), ($(c.getOppositeCase()), ""))
        .items)

# Process the current polymer until no pairs remain
proc processPolymer(): int =
    var done = false
    var iter: int = 1
    while not done:
        done = true
        var i: int = 0
        while i <= polymer.high:
            if i == polymer.high:
                if polymer.join("") != previous.join(""):
                    previous = toSeq(polymer.items)
                    done = false
                break

            if polymer[i].getOppositeCase() == polymer[i + 1]:
                polymer.delete(i)
                polymer.delete(i)
                i -= 2
                if i < 0: i = 0

            i += 1
        iter += 1
    return polymer.len

# Create and process all 26 polymers
for i in 0..25:
    let c: char = char(int(($'a')[0]) + i)
    polymer = input.removeLetter(c)
    let len: int = processPolymer()
    if len < shortest: shortest = len

echo shortest
