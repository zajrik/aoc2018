import tables, nre, times, algorithm, sugar
from strutils import splitLines, parseInt
from sequtils import map

type
    GuardSleepArray = array[60, int]

    Action = enum
        begin, wake, sleep

    Event = ref object
        time: int64
        minute: int
        action: Action
        id: int

let
    dateTimeRegex: Regex = re"^\[(.+)\]"
    minuteRegex: Regex = re"^\[\d{4}-\d{2}-\d{2} \d{2}:(\d{2})"
    guardRegex: Regex = re"^\[.+\] Guard #(\d+)"
    actionRegex: Regex = re"^\[.+\] (?:Guard #\d+ )?(falls|wakes|begins)"

# Forward declare createEvent()
proc createEvent(a: string): Event

var
    currentGuard: int = 0
    laziestGuard: int = 0

    highestIndex: int = 0
    highestValue: int = 0

    guards: Table[int, GuardSleepArray] = initTable[int, GuardSleepArray]()
    input: seq[Event] = readFile("input.txt")
        .splitLines
        .map(createEvent)

input.sort((a, b) => cmp(a.time, b.time))

# Create and return an Event object from the given string data
proc createEvent(a: string): Event =
    let
        parsedAction: string = a.match(actionRegex).get().captures[0]
        minute: int = parseInt(a.match(minuteRegex).get().captures[0])
        time: Time =
            parseTime(a.match(dateTimeRegex).get().captures[0], "yyyy-MM-dd HH:mm", utc())

    var
        id: int = 0
        action: Action

    if a.find(guardRegex).isSome():
        id = parseInt(a.match(guardRegex).get().captures[0])

    case parsedAction
        of "begins": action = Action.begin
        of "falls": action = Action.sleep
        of "wakes": action = Action.wake

    Event(time: time.toUnix(), minute: minute, action: action, id: id)

# Create and return a 0-filled array to contain guard sleep data
proc newGuardSleepArray(): GuardSleepArray =
    for a in result.mitems: a = 0

# Set up guard sleep data
for i, event in input.pairs:
    if event.id > 0: currentGuard = event.id
    else: event.id = currentGuard

    if not guards.hasKey(event.id):
        guards.add(event.id, newGuardSleepArray())

    case event.action
        of Action.wake: discard
        of Action.begin: discard
        of Action.sleep:
            for j in event.minute..(input[i + 1].minute - 1):
                guards[event.id][j] += 1

for k, v in guards.pairs:
    for i, j in v.pairs:
        if j > highestValue:
            highestValue = j
            highestIndex = i
            laziestGuard = k

echo laziestGuard * highestIndex