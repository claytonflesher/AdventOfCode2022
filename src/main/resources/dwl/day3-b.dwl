%dw 2.0
output application/java
import divideBy from dw::core::Arrays
import toArray from dw::util::Coercions

var data = readUrl("classpath://inputs/day3.txt", "text/plain") splitBy "\n"
	
var findMatchingLetters = (stringA: String, stringB: String, stringC: String) ->
	using (candidatesA = toArray(stringA) distinctBy $,
		candidatesB = toArray(stringB) distinctBy $,
		candidatesC = toArray(stringC) distinctBy $
	)
	candidatesA reduce (letter, acc = "") ->
		if ((candidatesB contains letter) and (candidatesC contains letter))
			letter
		else
			acc
		
var letterPriorities = {
	a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8, i: 9, j: 10,
	k: 11, l: 12, m: 13, n: 14, o: 15, p: 16, q: 17, r: 18, s: 19, t: 20,
	u: 21, v: 22, w: 23, x: 24, y: 25, z: 26, A: 27, B: 28, C: 29, D: 30,
	E: 31, F: 32, G: 33, H: 34, I: 35, J: 36, K: 37, L: 38, M: 39, N: 40,
	O: 41, P: 42, Q: 43, R: 44, S: 45, T: 46, U: 47, V: 48, W: 49, X: 50,
	Y: 51, Z: 52
}

var matchingLetters = (data divideBy 3) map (group) -> 
findMatchingLetters(group[0], group[1], group[2])

---
sum(matchingLetters map (letter) -> letterPriorities[letter])