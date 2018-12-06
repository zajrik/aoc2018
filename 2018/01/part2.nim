import tables
from strutils import parseInt, splitLines

var
    frequency: int = 0
    frequencies: Table[int, bool] = initTable[int, bool]()
    foundDuplicate: bool = false
    inputs: seq[string] = readFile("input.txt")
        .splitLines

while not foundDuplicate:
    for input in inputs:
        frequency += parseInt(input)

        if frequencies.hasKey(frequency):
            echo frequency
            foundDuplicate = true
            break
        
        else:
            frequencies.add(frequency, true)
