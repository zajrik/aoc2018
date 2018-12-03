from strutils import parseInt, splitLines
from sequtils import map, foldl

echo readFile("input.txt")
    .splitLines
    .map(parseInt)
    .foldl(a + b)
