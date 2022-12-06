%dw 2.0
output application/java
var data = readUrl("classpath://inputs/day2.txt", "text/plain") splitBy "\n"

var rounds = data map {
	opponent: opponentMap($[0]),
	myself: myMap($[-1])
}
var opponentMap = (play) -> 
	play match {
		case "A" -> "Rock"
		case "B" -> "Paper"
		case "C" -> "Scissors"
	}
var myMap = (play) ->
	play match {
		case "X" -> "Rock"
		case "Y" -> "Paper"
		case "Z" -> "Scissors"
	}
	
var calculateResults = (round) ->
	round match {
		case round if (round == {opponent: "Scissors", 	myself: "Rock"}) 		-> 7
		case round if (round == {opponent: "Rock", 		myself: "Paper"}) 		-> 8
		case round if (round == {opponent: "Paper", 	myself: "Scissors"}) 	-> 9
		case round if (round == {opponent: "Rock", 		myself: "Rock"}) 		-> 4
		case round if (round == {opponent: "Paper", 	myself: "Paper"}) 		-> 5
		case round if (round == {opponent: "Scissors", 	myself: "Scissors"}) 	-> 6
		case round if (round == {opponent: "Paper", 	myself: "Rock"}) 		-> 1
		case round if (round == {opponent: "Scissors", 	myself: "Paper"}) 		-> 2
		case round if (round == {opponent: "Rock", 		myself: "Scissors"}) 	-> 3
	}
var results = rounds map (round) -> calculateResults(round)
---
sum(results)