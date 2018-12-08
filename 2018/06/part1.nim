import tables, sets, sugar
from strutils import splitLines, split, parseInt
from sequtils import map, filter, toSeq

type Node = object
    x: int
    y: int

const GRID_SIZE: int = 1000

var
    counts: Table[int, int] = initTable[int, int]()
    infinities: HashSet[int] = initSet[int]()
    nodes: seq[Node] = readFile("input.txt")
        .splitLines
        .map(a => Node(x: parseInt(a.split(", ")[0]), y: parseInt(a.split(", ")[1])))

# Return the Manhattan Distance between two Points
proc manhattanDistance(a: Node, b: Node): int =
    abs(a.x - b.x) + abs(a.y - b.y)

# Returns the index of the node closest to the given coordinates
proc getClosest(x: int, y: int): int =
    var
        min: int = 10000
        minIndex: int = 0
        node: Node = Node(x: x, y: y)

    for i in 0 .. nodes.high:
        let distance: int = manhattanDistance(node, nodes[i])
        if distance < min:
            min = distance
            minIndex = i
        elif distance == min:
            min = distance
            minIndex = -1

    return minIndex

# Merge a value with the value of the given table and key using the predicate
# procedure or simply insert the value if it doesn't already exist
proc merge[T, U](t: var Table[T, U], k: T, v: U, fn: (a: U, b: U) -> U): void =
    var newVal: U

    if not t.hasKey(k): newVal = v
    else: newVal = fn(t[k], v)

    if t.hasKey(k): t[k] = newVal
    else: t.add(k, newVal)

# Return the maximum value within the given sequence
proc max[T](s: seq[T]): T =
    for item in s.items:
        if item > result: result = item

# Find solution
for i in 0 .. GRID_SIZE - 1:
    for j in 0 .. GRID_SIZE - 1:
        let distance: int = getClosest(i, j)
        counts.merge(distance, 1, (a, b) => a + b)

        if (i == 0) or (i == GRID_SIZE - 2) or (j == 0) or (j == GRID_SIZE - 2):
            infinities.incl(distance)

echo toSeq({0 .. nodes.high}.items)
    .filter(a => not infinities.contains(a))
    .map(a => counts[a])
    .max()