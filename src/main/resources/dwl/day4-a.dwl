%dw 2.0
output application/java
import every from dw::core::Arrays
var data = readUrl("classpath://inputs/day4.txt", "text/plain") splitBy "\n"
var arrayPairs = data map (line) -> 
	((line splitBy ",") map (nums) -> (nums splitBy "-")) map ($[0] to $[1])
var overlappingAssignments = arrayPairs filter (arrayPair) -> 
(arrayPair[0] every (arrayPair[1] contains $)) or 
(arrayPair[1] every (arrayPair[0] contains $))
---
sizeOf(overlappingAssignments)