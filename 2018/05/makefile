default:
	mkdir -p bin
	nim c -d:release -o:bin/part1 part1.nim
	nim c -d:release --threads:on --threadAnalysis:off -o:bin/part2 part2.nim
