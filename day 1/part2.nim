import tables
from strutils import parseInt

var
    frequencies: Table[int, bool] = initTable[int, bool]()
    frequency: int = 0
    foundDuplicate: bool = false
    file: File
    inputs: seq[string] = @[]

discard open(file, "input.txt")

while true:
    if endOfFile(file): break
    inputs.add(readLine(file))

close(file)

while not foundDuplicate:
    for input in inputs:
        frequency += parseInt(input)

        if frequencies.hasKey(frequency):
            echo frequency
            foundDuplicate = true
            break
        
        else:
            frequencies.add(frequency, true)
