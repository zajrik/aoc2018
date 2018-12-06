from sequtils import toSeq
from strutils import join

var
    polymer: seq[char] = toSeq(readFile("input.txt").string.items)
    previous: seq[char] = @[]
    done: bool = false
    iter: int = 1

# Return the opposite case of the given character
proc getOppositeCase(c: char): char =
    return char(int(c) xor 32)

# Process the polymer until no pairs remain
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

echo polymer.len
