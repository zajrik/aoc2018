import strutils, sequtils

var
    file: File
    inputs: seq[string] = @[]
    twos: int = 0
    threes: int = 0

discard open(file, "input.txt")

while true:
    if endOfFile(file): break
    inputs.add(readLine(file))

close(file)

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