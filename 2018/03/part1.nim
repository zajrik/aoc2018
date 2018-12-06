import sugar, strformat
from strutils import splitLines, parseInt, split
from seqUtils import map, filter

type
    FabricSection = object
        id: int
        left: int
        top: int
        width: int
        height: int

# Return whether the given point is within the bounds of the FabricSection
proc withinBounds(f: FabricSection, x: int, y: int): bool =
    x >= f.top and 
        y >= f.left and
        x < f.top + f.height and
        y < f.left + f.width
        
var
    total: int = 0
    input: seq[FabricSection] = readFile("input.txt")
        .splitLines
        .map(a => a.split(" "))
        .map(a => a.filter(b => b != "@"))
        .map(a => FabricSection(
            id: parseInt($a[0][1..^1]),
            left: parseInt(a[1].split(',')[0]),
            top: parseInt(a[1].split(',')[1][0..^2]),
            width: parseInt(a[2].split('x')[0]),
            height: parseInt(a[2].split('x')[1])))

# Return the number of intersections at the given point out of all FabricSections
proc numberOfIntersectsAtPoint(x: int, y: int): int =
    for square in input:
        if square.withinBounds(x, y):
            result += 1

for i in 0..999:
    for j in 0..999:
        if numberOfIntersectsAtPoint(i, j) >= 2:
            total += 1

echo total
