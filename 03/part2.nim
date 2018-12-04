import sugar, math
from strutils import splitLines, parseInt, split
from seqUtils import map, filter

type
    FabricSection = object
        id: int
        x: int
        y: int
        w: int
        h: int

var
    index: int = 0
    points {.noinit.}: array[2 ^ 20, int]
    input: seq[FabricSection] = readFile("input.txt")
        .splitLines
        .map(a => a.split(" "))
        .map(a => a.filter(b => b != "@"))
        .map(a => FabricSection(
            id: parseInt($a[0][1..^1]),
            x: parseInt(a[1].split(',')[0]),
            y: parseInt(a[1].split(',')[1][0..^2]),
            w: parseInt(a[2].split('x')[0]),
            h: parseInt(a[2].split('x')[1])))

for a in points.mitems: a = 0

for item in input:
    for i in item.y .. item.y + item.h:
        for j in item.x .. item.x + item.w:
            index = (i * 1000) + j
            points[index] += 1

# Find the first item in the sequence matching the given predicate
proc find(a: seq[FabricSection], fn: FabricSection -> bool): FabricSection =
    for i in a:
        if fn(i): return i

echo input.find(proc (f: FabricSection): bool =
    index = 0
    for i in f.y .. f.y + f.h:
        for j in f.x .. f.x + f.w:
            index = (i * 1000) + j
            if points[index] > 1: return false
    return true)