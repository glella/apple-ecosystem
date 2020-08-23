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
