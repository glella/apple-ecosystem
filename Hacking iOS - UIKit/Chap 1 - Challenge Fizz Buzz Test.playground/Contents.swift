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


// Better solution a la Rust match statement - more efficient as it only divides the numbew twice instead of 2-4
func fizzbuzz3(number: Int) -> String {
    switch (number % 3, number % 5) {
    case (0, 0):
        return "Fizz Buzz"
    case (0, _):
        return "Fizz"
    case (_, 0):
        return "Buzz"
    case (_, _):
        return String(number)
    }
}

fizzbuzz3(number: 3)     // Fizz
fizzbuzz3(number: 5)     // Buzz
fizzbuzz3(number: 15)    // Fizz Buzz
fizzbuzz3(number: 16)    // "16"

// Testing performace very simply not using XCTest - perhaps hot propper as it does not run 20 times and you do not get an average,
// BUT much simpler (and you could run it multile times and average it yourself. Intended for measurement rather than test passing
// The former will log out the time required for a given section of code, with the latter returning that as a float
func printTimeElapsedWhenRunningCode(title:String, operation:()->()) {
    let startTime = CFAbsoluteTimeGetCurrent()
    operation()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    let time = String(format: "$%.12f", timeElapsed)
    //print("Time elapsed for \(title): \(timeElapsed) s.")
    print("Time elapsed for \(title): \(time) s.")
}

func timeElapsedInSecondsWhenRunningCode(operation: ()->()) -> Double {
    let startTime = CFAbsoluteTimeGetCurrent()
    operation()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    return Double(timeElapsed)
}

printTimeElapsedWhenRunningCode(title: "mine", operation: { fizzbuzz(number: 16) })
printTimeElapsedWhenRunningCode(title: "paul", operation: { fizzbuzz2(number: 16) })
printTimeElapsedWhenRunningCode(title: "rust", operation: { fizzbuzz3(number: 16) })

// Now using XCTest
import XCTest

class MyTests: XCTestCase {
    func testPerformaneMine() {
        measure {
            fizzbuzz(number: 16)
        }
    }
    func testPerformanePaul() {
        measure {
            fizzbuzz2(number: 16)
        }
    }
    func testPerformaneRusr() {
        measure {
            fizzbuzz3(number: 16)
        }
    }
}

MyTests.defaultTestSuite.run()
