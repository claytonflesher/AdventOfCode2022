%dw 2.0
output application/java
var data = readUrl("classpath://inputs/day2.txt", "text/plain") splitBy "\n"

var rounds = data map {
	result: resultsMap($[-1]),
	opponent: opponentMap($[0]),
}
var opponentMap = (play) -> 
	play match {
		case "A" -> "Rock"
		case "B" -> "Paper"
		case "C" -> "Scissors"
	}
	
var resultsMap = (play) ->
	play match {
		case "X" -> "Loss"
		case "Y" -> "Draw"
		case "Z" -> "Win"
	}
	
var calculateMyPlay = (round) ->
	round match {
		case round if (round == {result: "Loss", opponent: "Rock"})   	-> round ++ {myself: "Scissors"}
		case round if (round == {result: "Loss", opponent: "Paper"}) 	-> round ++ {myself: "Rock"}
		case round if (round == {result: "Loss", opponent: "Scissors"}) -> round ++ {myself: "Paper"}
		case round if (round == {result: "Draw", opponent: "Rock"}) 	-> round ++ {myself: "Rock"}
		case round if (round == {result: "Draw", opponent: "Paper"}) 	-> round ++ {myself: "Paper"}
		case round if (round == {result: "Draw", opponent: "Scissors"}) -> round ++ {myself: "Scissors"}
		case round if (round == {result: "Win", opponent: "Rock"}) 		-> round ++ {myself: "Paper"}
		case round if (round == {result: "Win", opponent: "Paper"}) 	-> round ++ {myself: "Scissors"}
		case round if (round == {result: "Win", opponent: "Scissors"}) 	-> round ++ {myself: "Rock"}
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
	
var roundsWithMyPlays = rounds map (round) -> calculateMyPlay(round)

var results = roundsWithMyPlays map (round) -> calculateResults(round - 'result')
---
sum(results)