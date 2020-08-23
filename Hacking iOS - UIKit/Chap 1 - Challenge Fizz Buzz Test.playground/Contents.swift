import UIKit

func fizzbuzz(number i: Int) -> String {
    var answer: String = String(i)
    
    if i % 3 == 0 && i % 5 == 0 {
        answer = "Fizz Buzz"
    } else if i % 3 == 0 {
        answer = "Fizz"
    } else if i % 5 == 0 {
        answer = "Buzz"
    }
    
    return answer
}

fizzbuzz(number: 3)     // Fizz
fizzbuzz(number: 5)     // Buzz
fizzbuzz(number: 15)    // Fizz Buzz
fizzbuzz(number: 16)    // "16"

// Proposed book solution
// Better in terms of returning right away with response with no need to go through the rest of the statements
// and no local variable

func fizzbuzz2(number: Int) -> String {
    
    if number % 3 == 0 && number % 5 == 0 {
        return "Fizz Buzz"
    } else if number % 3 == 0 {
        return "Fizz"
    } else if number % 5 == 0 {
        return "Buzz" } else {
      return String(number)
   }
}

fizzbuzz2(number: 3)     // Fizz
fizzbuzz2(number: 5)     // Buzz
fizzbuzz2(number: 15)    // Fizz Buzz
fizzbuzz2(number: 16)    // "16"
