%dw 2.0
output application/java
var data = readUrl("classpath://inputs/day1.txt", "text/plain")
var chunks = data splitBy "\n\n"
var numbers = chunks map (chunk) -> 
	((chunk splitBy "\n") map $ as Number)
var threeLargest = ((numbers reduce ((group, acc = []) -> 
	acc + sum(group)
)) orderBy -$)[0 to 2]
---
sum(threeLargest)