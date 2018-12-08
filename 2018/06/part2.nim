import sugar
from strutils import splitLines, split, parseInt
from sequtils import map

type Node = object
    x: int
    y: int

const GRID_SIZE: int = 1000

var
    count: int = 0
    nodes: seq[Node] = readFile("input.txt")
        .splitLines
        .map(a => Node(x: parseInt(a.split(", ")[0]), y: parseInt(a.split(", ")[1])))

# Return the Manhattan Distance between two Points
proc manhattanDistance(a: Node, b: Node): int =
    abs(a.x - b.x) + abs(a.y - b.y)

# Find solution
for i in 0 .. GRID_SIZE - 1:
    for j in 0 .. GRID_SIZE - 1:
        var
            current: Node = Node(x: j, y: i)
            sum: int

        for node in nodes:
            sum += current.manhattanDistance(node)
        
        if sum < 10000: count += 1

echo count