%dw 2.0
output application/json
import toArray, toString from dw::util::Coercions
import drop, take from dw::core::Arrays
import isNumeric, isUpperCase from dw::core::Strings
var data = readUrl("classpath://inputs/day5.txt", "text/plain") splitBy "\n\n"

var stacks = 
	((data[0] splitBy "\n") map toArray($)) 
		reduce (($$ zip $) map flatten($))
		filter isNumeric($[-1])
		map (stack) -> stack filter isUpperCase($)
		
var moves = data[1] splitBy "\n" 
	map 
		using (matches = ($ match(/move (\d+) from (\d+) to (\d+)/)))
		{
			amount: matches[1] as Number,
			from: matches[2] as Number - 1,
			to: matches[3] as Number - 1
		}
		
var restacked = moves reduce (move, acc = stacks) -> 
	acc map (stack, index) -> 
		if (move.from == index)
			stack drop move.amount
		else if (move.to == index)
			(acc[move.from] take move.amount) ++ stack
		else
			stack
---
toString(restacked map $[0])