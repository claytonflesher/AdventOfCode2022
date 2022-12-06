%dw 2.0
output application/java
var data = readUrl("classpath://inputs/day1.txt", "text/plain")
var chunks = data splitBy "\n\n"
var numbers = chunks map (chunk) -> 
	((chunk splitBy "\n") map $ as Number)
---
numbers reduce ((group, acc = 0) -> 
	using (summed = sum(group))
	if (summed > acc)
		summed
	else
		acc
)