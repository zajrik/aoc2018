from sequtils import toSeq, count
from strutils import splitLines

var
    twos: int = 0
    threes: int = 0
    inputs: seq[string] = readFile("input.txt")
        .splitLines

for input in inputs:
    let letters: seq[char] = toSeq(input.items)
    var
        two: bool = false
        three: bool = false

    for letter in letters:
        let count: int = letters.count(letter)
        if count == 2: two = true
        if count == 3: three = true

    if two: twos += 1
    if three: threes += 1

echo twos * threes
