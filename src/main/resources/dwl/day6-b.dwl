%dw 2.0
output application/java
import toArray from dw::util::Coercions

var data = readUrl("classpath://inputs/day6.txt", "text/plain")

var isUnique = (array) -> array == (array distinctBy $)

var charactersICareAbout = 
    toArray(data) reduce (item, accumulator = {found: false, acc: []}) -> 
        if (sizeOf(accumulator.acc) < 14)
            {found: false, acc: accumulator.acc + item}
        else if (accumulator.found)
            {found: true, acc: accumulator.acc}
        else if ((not accumulator.found) and (isUnique(accumulator.acc[-13 to -1] + item)))
            {found: true, acc: accumulator.acc + item}
        else
            {found: false, acc: accumulator.acc + item}
---
sizeOf(charactersICareAbout.acc)