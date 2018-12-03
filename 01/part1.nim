from strutils import parseInt

var
    input: File
    frequency: int = 0

discard open(input, "input.txt")

while true:
    if endOfFile(input):
        close(input)
        break

    frequency += parseInt(readLine(input))

echo frequency
