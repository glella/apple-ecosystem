import UIKit

// variables & constants - String, Int, Double, Bool
var str = "Hello, playground"
var age = 53
var pi = 3.14
var awesome = true
var score = 85
var str2 = "Your score was \(score)"
let taylor = "swift"
let album: String = "Reputation"

// arrays
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"
let beatles = [john, paul, george, ringo]
// same as this with type annotation: let beatles [String] = [john, paul, george, ringo]
beatles[1]

// sets - no order & every item must be unique
let colors = Set(["red", "green", "blue"]) // sets from arrays
let colors2 = Set(["red", "green", "blue", "red", "blue"]) // duplicates ignored

// tuples - store several values together - cannot add or remove elements
// although you can change them but always with the same type
// You can access items in a tuple using numerical positions or by naming them
var name = (first: "Taylor", last: "Swift")
name.0
name.first

// arrays vs sets vs tuples - arrays are the most common
// If you need a specific, fixed collection of related values where each item has a precise
// position or name, you should use a tuple:
 let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")
// If you need a collection of values that must be unique or you need to be able to check
// whether a specific item is in there extremely quickly, you should use a set:
let set = Set(["aardvark", "astronaut", "azalea"])
// If you need a collection of values that can contain duplicates, or the order of your items
// matters, you should use an array:
 let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]

// dictionaries - collections of values just like arrays, but rather than storing things with
// an integer position you can access them using anything you want.
let heights = [
   "Taylor Swift": 1.78,
   "Ed Sheeran": 1.73
]
// identifiers are called keys, and you can use them to read values back out of the dictionary:
heights["Taylor Swift"]
// using type annotation: [String: Double]
// dictionaries default values - if element does not exist instead of returnin nil:
let favoriteIceCream = [
   "Paul": "Chocolate",
   "Sophie": "Vanilla"
]
favoriteIceCream["Charlotte", default: "Unknown"]

// empty collections -  just write its type followed by opening and closing parentheses
// dictionary:
var teams = [String: String]()
// adding:
teams["Paul"] = "Red"
// array:
var results = [Int]()
// set - Swift has special syntax only for dictionaries and arrays; other types must
// use angle bracket
var numbers = Set<Int>()

// enumerations - way of defining groups of related values
enum Result {
   case success
   case failure
}
// enums can also store associated values attached to each case
enum Activity {
   case bored
   case running(destination: String)
   case talking(topic: String)
   case singing(volume: Int)
}
let talking = Activity.talking(topic: "football")
// enum raw values so they have meaning / starting with zero unless specified
enum Planet: Int {
   case mercury
   case venus
   case earth
   case mars
}
let earth = Planet(rawValue: 2)
// you can assign one or more cases a specific value, and Swift will generate the rest
enum Planet2: Int {
   case mercury = 1
   case venus
   case earth
case mars }
let earth2 = Planet2(rawValue: 3)

// arithmetic operators
let firstScore = 12
let secondScore = 4
let total = firstScore + secondScore
let difference = firstScore - secondScore
let product = firstScore * secondScore
let divided = firstScore / secondScore
let remainder = 13 % secondScore

// operator overloading - what an operator does depends on the values you use it with
// ie for +:
// int
let meaningOfLife = 42
let doubleMeaning = 42 + 42
// string
let fakers = "Fakers gonna "
let action = fakers + "fake"
// array
let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles2 = firstHalf + secondHalf

// compound assignment operators: += -= *= /=
var score2 = 95
score2 -= 5

// comparison operators == != < > >= <=
let firstScore2 = 6
let secondScore2 = 4
firstScore2 == secondScore2
firstScore2 != secondScore2

// conditions
let firstCard = 11
let secondCard = 10
if firstCard + secondCard == 21 {
   print("Blackjack!")
} else {
   print("Regular cards")
}
// optional else if:
if firstCard + secondCard == 2 {
   print("Aces – lucky!")
} else if firstCard + secondCard == 21 {
   print("Blackjack!")
} else {
   print("Regular cards")
}

// combining conditions - logical operators && (and) and ||(or)
let age1 = 12
let age2 = 21
if age1 > 18 && age2 > 18 {
   print("Both are over 18")
}

// ternary operator
let firstCard2 = 11
let secondCard2 = 10
print(firstCard == secondCard ? firstCard2 : secondCard2)

// switch statement
// default is required because Swift makes sure you cover all possible cases
// use fallthrough if you want to fallthrough
let weather = "sunny"
switch weather {
case "rain":
   print("Bring an umbrella")
case "snow":
   print("Wrap up warm")
case "sunny":
   print("Wear sunscreen")
default:
   print("Enjoy your day!")
}

// range operators
// ..< creates ranges up to but excluding the final value
// ... creates ranges up to and including the final value
let score3 = 85
switch score3 {
case 0..<50:
   print("You failed badly.")
case 50..<85:
   print("You did OK.")
default:
   print("You did great!")
}

// Looping
// for loops - it will loop over arrays and ranges, and each time the loop goes around it will
// pull out one item and assign to a constant.
// over ranges
let count = 1...10
for number in count {
   print("Number is \(number)")
}
// over arrays
let albums = ["Red", "1989", "Reputation"]
for album in albums {
   print("\(album) is on Apple Music")
}
// If you don’t use the constant that for loops give you, you should use an underscore
print("Players gonna ")
for _ in 1...5 {
   print("play")
}
// while loops - its loop code will go around and around until the condition fails
var number = 1
while number <= 5 {
   print(number)
   number += 1
}
print("Ready or not, here I come!")
// repeat loops - same as while but confdition at the end so it runs at least once
var number2 = 1
repeat {
   print(number2)
   number2 += 1
} while number2 <= 5
print("Ready or not, here I come!")
// exit loops with break
// for nested loops give the outside loop a label and break to that label if you want
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")
        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}
// skip current item and go to the next iteration with continue
// common to use while loops to create infinite loops like: while true

// functions
func printHelp() {
   let message = """
Welcome to MyApp!
Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""
   print(message)
}
printHelp()
// with parameters and return - Use tuples if you want to return several things.
func square(number: Int) -> Int {
   return number * number
}
let result = square(number: 8)
print(result)
// Swift lets us provide two names for each parameter: one to be used externally when calling the function,
// and one to be used internally inside the function.
func sayHello(to name: String) {
   print("Hello, \(name)!")
}
// The parameter is called to name, which means externally it’s called to, but internally it’s called name.
// This gives variables a sensible name inside the function, but means calling the function reads naturally:
sayHello(to: "Taylor")
// Omitting parameter labels
// using an underscore, _, for your external parameter name, like this:
func greet(_ person: String) {
   print("Hello, \(person)!")
}
greet("Taylor")
// it’s better to give your parameters external names to avoid confusion
// Default parameters
func greet2(_ person: String, nicely: Bool = true) {
   if nicely == true {
      print("Hello, \(person)!")
   } else {
      print("Oh no, it's \(person) again...")
   }
}
greet2("Taylor")
greet2("Taylor", nicely: false)
// Variadic functions
// Some functions are variadic, which is a fancy way of saying they accept any number of parameters of the same type.
// You can make any parameter variadic by writing ... after its type. So, an Int parameter is a
// single integer, whereas Int... is zero or more integers – potentially hundreds.
// Inside the function, Swift converts the values that were passed in to an array of integers, so you
// can loop over them as needed.
func square2(numbers: Int...) {
   for number in numbers {
      print("\(number) squared is \(number * number)")
   }
}
square2(numbers: 1, 2, 3, 4, 5)
// Writing throwing functions
// Sometimes functions fail because they have bad input, or because something went wrong internally. Swift lets
// us throw errors from functions by marking them as throws before their return type, then using the throw keyword
// when something goes wrong.
// First we need to define an enum that describes the errors we can throw. These must always be based on Swift’s
// existing Error type.
enum PasswordError: Error {
   case obvious
}
func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}
// Running throwing functions
// Swift doesn’t like errors to happen when your program runs, which means it won’t let you run an error-throwing
// function by accident.
// you need to call these functions using three new keywords: do starts a section of code that might cause problems,
// try is used before every function that might throw an error, and catch lets you handle errors gracefully.
do {
    try checkPassword("password")
    print("That password is good!") // will never get run because if in error execution goes to catch
} catch {
   print("You can't use that password.")
}
// When that code runs, “You can’t use that password” is printed, but “That password is good” won’t be – that code
// will never be reached, because the error is thrown.
// inout parameters
// All parameters passed into a Swift function are constants, so you can’t change them. If you want, you can pass in
// one or more parameters as inout, which means they can be changed inside your function
// change the value directly rather than returning a new one
// To use that, you first need to make a variable integer & pass the parameter using an ampersand, &
func doubleInPlace(number: inout Int) {
   number *= 2
}
var myNum = 10
doubleInPlace(number: &myNum)

// Closures
let driving = {
   print("I'm driving in my car")
}
// That effectively creates a function without a name, and assigns that function to driving.
// You can now call driving() as if it were a regular function, like this:
driving()
// With parameters. List them inside parentheses just after the opening brace, then write in
let driving2 = { (place: String) in
   print("I'm going to \(place) in my car")
}
driving2("London")
// returning values - they are written similarly to parameters: you write them inside your closure, before in
let drivingWithReturn = { (place: String) -> String in
   return "I'm going to \(place) in my car"
}
 let message = drivingWithReturn("Buenos Aires")
print(message)
// Closures as parameters
func travel(action: () -> Void) {
   print("I'm getting ready to go.")
   action()
   print("I arrived!")
}
travel(action: driving)
// Trailing closure syntax
// Because travel func last parameter is a closure, we can call travel() using trailing closure syntax like this:
travel() {
   print("I'm flying in my plane")
}
// or as it has no other parameters you can eliminate parenthesis
travel {
   print("I'm navigating in my yatch")
}
// Using closures as parameters when they accept parameters
func travel2(action: (String) -> Void) {
   print("I'm getting ready to go.")
   action("London")
   print("I arrived!")
}
travel2 { (place: String) in
   print("I'm going to \(place) in my car")
}
// Using closures as parameters when they return values
func travel3(action: (String) -> String) {
   print("I'm getting ready to go.")
   let description = action("London")
   print(description)
   print("I arrived!")
}
travel3 { (place: String) -> String in
   return "I'm going to \(place) in my car"
}
// shorthand parameter names
// Swift knows the parameter to that closure must be a string, so we can remove it
travel3 { place -> String in
   return "I'm going to \(place) in my car"
}
// It also knows the closure must return a string, so we can remove that:
travel3 { place in
   return "I'm going to \(place) in my car"
}
// As the closure only has one line of code that must be the one that returns the value, so we can remove return
travel3 { place in
   "I'm going to \(place) in my car"
}
// even shorter: we can let Swift provide automatic names for the closure’s parameters. These are named with a
// dollar sign, then a number counting from 0.
travel3 {
   "I'm going to \($0) in my car"
}
// closures with mutiple parameters
func travel4(action: (String, Int) -> String) {
   print("I'm getting ready to go.")
   let description = action("London", 60)
   print(description)
   print("I arrived!")
}
travel4 {
   "I'm going to \($0) at \($1) miles per hour."
}
// returning closures from functions
//  it uses -> twice: once to specify your function’s return value, and a second time to specify your
// closure’s return value.
// write a travel() function that accepts no parameters, but returns a closure.
// The closure that gets returned must be called with a string, and will return nothing.
func travel5() -> (String) -> Void {
   return {
      print("I'm going to \($0)")
   }
}
let result2 = travel5()
result2("London")
// capturing values
// If you use any external values inside your closure, Swift captures them – stores them alongside the closure,
// so they can be modified even if they don’t exist any more.
// For example, we might want to track how often the returned closure is called:
func travel6() -> (String) -> Void {
   var counter = 1
   return {
      print("\(counter). I'm going to \($0)")
      counter += 1
} }
// Even though that counter variable was created inside travel(), it gets captured by the closure so it
// will still remain alive for that closure.
let result3 = travel6()
result3("London")
result3("London")
result3("London")

// structs
struct Sport {
   var name: String
}
var tennis = Sport(name: "Tennis")
print(tennis.name)
// We made both name and tennis variable, so we can change them just like regular variables:
tennis.name = "Lawn tennis"
// also, Properties can have default values just like regular variables
// computed properties
// name above is a stored property. There are also computed properties:
struct Sport2 {
   var name: String
   var isOlympicSport: Bool
   var olympicStatus: String { // this is the computed property
      if isOlympicSport {
         return "\(name) is an Olympic sport"
      } else {
         return "\(name) is not an Olympic sport"
      }
    }
}
let chessBoxing = Sport2(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)
// property obververs - Property observers let you run code before or after any property changes.
// using didSet (and willSet which is rarely used)
// we’ll write a Progress struct that tracks a task and a completion percentage:
struct Progress {
   var task: String
   var amount: Int {
      didSet {
         print("\(task) is now \(amount)% complete")
        }
    }
}
var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100
// methods
struct City {
   var population: Int
   func collectTaxes() -> Int {
      return population * 1000
    }
}
 let london = City(population: 9_000_000)
london.collectTaxes()
// mutating methods
// If a struct has a variable property but the instance of the struct was created as a constant, that property
// can’t be changed – the struct is constant, so all its properties are also constant regardless of how they
// were created.
// The problem is that when you create the struct Swift has no idea whether you will use it with constants or
// variables, so by default it takes the safe approach: Swift won’t let you write methods that change properties
// unless you specifically request it.
// When you want to change a property inside a method, you need to mark it using the mutating keyword, like this:
struct Person {
   var name: String
   mutating func makeAnonymous() {
      name = "Anonymous"
    }
}
// Because it changes the property, Swift will only allow that method to be called on Person instances that are
// variables:
var person = Person(name: "Ed")
person.makeAnonymous()
// properties and methods of strings - they are structs
let string = "Do or do not, there is no try."
print(string.count)
print(string.hasPrefix("Do"))
print(string.uppercased())
print(string.sorted())
// properties and methods of arrays - they are structs too
var toys = ["Woody"]
print(toys.count)
toys.append("Buzz")
print(toys.firstIndex(of: "Buzz")!) // optional coerced with !
print(toys.sorted())
toys.remove(at: 0)
// initializers
// Initializers are special methods that provide different ways to create your struct. All structs come with
// one by default, called their memberwise initializer – this asks you to provide a value for each property
// when you create the struct.
struct User {
   var username: String
}
var user = User(username: "twostraws")
// We can provide our own initializer to replace the default one.
// You don’t write func before initializers, but you do need to make sure all properties have a value before
// the initializer ends.
struct User2 {
   var username: String
   init() {
      username = "Anonymous"
      print("Creating a new user!")
    }
}
var user2 = User2()
print(user2.username)
user2.username = "Willy"
print(user2.username)
// referring to current instance
struct Person2 {
   var name: String
   init(name: String) {
      print("\(name) was born!")
      self.name = name
    }
}
// lazy properties
// As a performance optimization, Swift lets you create some properties only when they are needed.
struct FamilyTree {
   init() {
      print("Creating family tree!")
   }
}
// We might use that FamilyTree struct as a property inside a Person struct
struct Person3 {
   var name: String
   lazy var familyTree = FamilyTree() // Swift will only create the FamilyTree struct when it’s first accessed
   init(name: String) {
      self.name = name
    }
}
var ed = Person3(name: "Ed")
ed.familyTree
// Static properties and methods
// You can share specific properties and methods across all instances of the struct by declaring them as static
// we’re going to add a static property to the Student struct to store how many students are in the class.
// Each time we create a new student, we’ll add one to it:
struct Student {
   static var classSize = 0
   var name: String
   init(name: String) {
      self.name = name
      Student.classSize += 1
    }
}
var willy = Student(name: "Willy")
// Because the classSize struct belongs to the struct itself rather than instances of the struct, we need to
// read it using Student.classSize:
print(Student.classSize)
// access control - with private you can’t read it from outside the struct
struct Person4 {
   private var id: String
   init(id: String) {
      self.id = id
    }
    func identify() -> String {
          return "My social security number is \(id)"
    }
}
var gustavo = Person4(id: "1234")
print(gustavo.identify())

// clases - similar to struct but with 5 diferences
// 1 - if you have properties in your class, you must always create your own initializer.
class Dog {
   var name: String
   var breed: String
   init(name: String, breed: String) {
      self.name = name
      self.breed = breed
    }
    func makeNoise() {
       print("Woof!")
    }
}
// Creating instances of that class looks just the same as if it were a struct:
// let poppy = Dog(name: "Poppy", breed: "Poodle")
// 2 - Inheritance - you can create a class based on an existing class – it inherits all the properties and
// methods of the original class, and can add its own on top.
class Poodle: Dog {
    init(name: String) {
    super.init(name: name, breed: "Poodle")
    }
    override func makeNoise() {
       print("Yip!")
    }
}
// overriding methods -  use override func rather than just func when overriding a method
let poppy = Poodle(name: "Poppy")
poppy.makeNoise()
// final clases - sometimes you want to disallow other developers from building their own class based on yours.
// when you declare a class as being final, no other class can inherit from it
final class Dog2 {
   var name: String
   var breed: String
   init(name: String, breed: String) {
      self.name = name
      self.breed = breed
    }
}
// 3 - The third difference between classes and structs is how they are copied. When you copy a struct, both the
// original and the copy are different things – changing one won’t change the other. When you copy a class
// INSTANCE, both the original and the copy point to the same thing, so changing one does change the other.
class Singer {
   var name = "Taylor Swift"
}
var singer = Singer()
print(singer.name)
// a copy of it points to the same object in memory (as reference)
 var singerCopy = singer
singerCopy.name = "Justin Bieber"
print(singer.name)
// in a struct each will have their own value
struct Singer2 {
   var name = "Taylor Swift"
}
var singer2 = Singer2()
print(singer2.name)
// its copy will have a different value (as value)
var singer2Copy = singer2
singer2Copy.name = "Willy"
print(singer2Copy.name)
// 4 - Deinitializers - can have code that gets run when an instance of a class is destroyed.
// example creating and destroying instance in a loop:
class PersonX {
    var name = "John Doe"
    init() {
        print("\(name) is alive!")
    }
    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    deinit {
       print("\(name) is no more!")
    }
}
for _ in 1...3 {
   let person = PersonX()
   person.printGreeting()
}
// 5 - Mutability
// The final difference between classes and structs is the way they deal with constants. If you have a constant
// struct with a variable property, that property can’t be changed because the struct itself is constant.
// However, if you have a constant class with a variable property, that property can be changed. Because of
// this,classes don’t need the mutating keyword with methods that change properties; that’s only needed with
// structs.
// This difference means you can change any variable property on a class even when the class is created as
// constant – this is perfectly valid code:
class Singer3 {
   var name = "Taylor Swift"
}
let taylor2 = Singer3()
taylor2.name = "Ed Sheeran"
print(taylor2.name)
// If you want to stop that from happening you need to make the property constant using let
// let name = "Taylor Swift"


// *** protocols and extensions

// protocols - Protocols are a way of describing what properties and methods something must have. You then tell
// Swift which types use that protocol – a process known as adopting or conforming to a protocol.
// For example, we can write a function that accepts something with an id property, but we don’t care precisely
// what type of data is used. We’ll start by creating an Identifiable protocol, which will require all conforming
// types to have an id string that can be read (“get”) or written (“set”):
protocol Identifiable {
   var id: String { get set }
}
struct UserX: Identifiable {
   var id: String
}
// Finally, we’ll write a displayID() function that accepts any Identifiable object:
func displayID(thing: Identifiable) {
   print("My ID is \(thing.id)")
}

// protocol inhertance - you can inherit from multiple protocols at the same time
protocol Payable {
   func calculateWages() -> Int
}
protocol NeedsTraining {
   func study()
}
protocol HasVacation {
   func takeVacation(days: Int)
}
// we can create a single Employee protocol that brings them together in one protocol.
protocol Employee: Payable, NeedsTraining, HasVacation { }

// Extensions - allow you to add methods to existing types
extension Int {
   func squared() -> Int {
      return self * self
   }
}
let number3 = 8
number3.squared()
// Swift doesn’t let you add stored properties in extensions, so you must use computed properties instead. For
// example, we could add a new isEven computed property to integers that returns true if it holds an even number:
extension Int {
   var isEven: Bool {
      return self % 2 == 0
   }
}

// protocol extensions - you extend a protocol changing all instanes that implement it
// Protocols let you describe what methods something should have, but don’t provide the code inside. Extensions
// let you provide the code inside your methods, but only affect one data type – you can’t add the method to lots
// of types at the same time.
// Protocol extensions solve both those problems: they are like regular extensions, except rather than extending
// a specific type like Int you extend a whole protocol so that all conforming types get your changes.
// For example, here is an array and a set containing some names:
let pythons2 = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles3 = Set(["John", "Paul", "George", "Ringo"])
// Swift’s arrays and sets both conform to a protocol called Collection, so we can write an extension to that
// protocol to add a summarize() method to print the collection neatly
extension Collection {
   func summarize() {
      print("There are \(count) of us:")
      for name in self {
         print(name)
} }
}
pythons2.summarize()
beatles3.summarize()

// protocol oriented programming
// Protocol extensions can provide default implementations for our own protocol methods. This makes it easy for
// types to conform to a protocol, and allows a technique called “protocol- oriented programming” – crafting
// your code around protocols and protocol extensions.
// First, here’s a protocol called Identifiable that requires any conforming type to have an id property and a
// identify() method:
protocol Identifiable2 {
   var id: String { get set }
   func identify()
}
// We could make every conforming type write their own identify() method, but protocol extensions allow us to
// provide a default:
extension Identifiable2 {
   func identify() {
      print("My ID is \(id).")
   }
}
// Now when we create a type that conforms to Identifiable it gets identify() automatically:
struct User3: Identifiable2 {
   var id: String
}
let twostraws = User3(id: "twostraws")
twostraws.identify()


// *** Optionals

// handling missing data
// you can make optionals out of any type. An optional integer might have a number like 0 or 40, but it might have
// no value at all – it might literally be missing, which is nil in Swift.
var age3: Int? = nil
// That doesn’t hold any number – it holds nothing. But if we later learn that age, we can use it:
age3 = 38

// unwrapping optionals
var name2: String? = nil
// A common way of unwrapping optionals is with if let syntax, which unwraps with a condition. If there was
// a value inside the optional then you can use it, but if there wasn’t the condition fails
if let unwrapped = name2 {
   print("\(unwrapped.count) letters")
} else {
   print("Missing name.")
}
// If name holds a string, it will be put inside unwrapped as a regular String and we can read its count property
// inside the condition. Alternatively, if name is empty, the else code will be run.

// unwrapping with guard
// An alternative to if let is guard let, which also unwraps optionals. guard let will unwrap an optional for you,
// but if it finds nil inside it expects you to exit the function, loop, or condition you used it in.
// However, the major difference between if let and guard let is that your unwrapped optional remains usable
// after the guard code.
func greet2(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }
    print("Hello, \(unwrapped)!")
}
// Using guard let lets you deal with problems at the start of your functions, then exit immediately. This
// means the rest of your function is the happy path – the path your code takes if everything is correct.

// force unwrapping
// Optionals represent data that may or may not be there, but sometimes you know for sure that a value isn’t nil.
// In these cases, Swift lets you force unwrap the optional: convert it from an optional type to a non-optional
// type.
let str3 = "5"
let num = Int(str3) // num here is an optional int
let num2 = Int(str3)! // force unwrapped with !
// But if you’re wrong – if str was something that couldn’t be converted to an integer – your code will crash.

// implicitly unwrapped optionals
// Like regular optionals, implicitly unwrapped optionals might contain a value or they might be nil. However,
// unlike regular optionals you don’t need to unwrap them in order to use them: you can use them as if they
// weren’t optional at all.
let age4: Int! = nil
// if you try to use them and they have no value – if they are nil – your code crashes.
// Implicitly unwrapped optionals exist because sometimes a variable will start life as nil, but will always have
// a value before you need to use it. Because you know they will have a value by the time you need them, it’s
// helpful not having to write if let all the time.
// That being said, if you’re able to use regular optionals instead it’s generally a good idea.

// Nil coalescing - ??
// The nil coalescing operator unwraps an optional and returns the value inside if there is one. If there isn’t
// a value – if the optional was nil – then a default value is used instead. Either way, the result won’t be
// optional: it will either by the value from inside the optional or the default value used as a back up.
// Here’s a function that accepts an integer as its only parameter and returns an optional string:
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}
// If we call that with ID 15 we’ll get back nil because the user isn’t recognized, but with nil coalescing we can
// provide a default value of “Anonymous” like this:
let user6 = username(for: 15) ?? "Anonymous"

// optional chaining
// Swift provides us with a shortcut when using optionals: if you want to access something like a.b.c and b is
// optional, you can write a question mark after it to enable optional chaining: a.b?.c.
// When that code is run, Swift will check whether b has a value, and if it’s nil the rest of the line will be
// ignored – Swift will return nil immediately. But if it has a value, it will be unwrapped and execution will
// continue.
let names = ["John", "Paul", "George", "Ringo"]
// We’re going to use the first property of that array, which will return the first name if there is one or nil
// if the array is empty. We can then call uppercased() on the result to make it an uppercase string:
let beatle = names.first?.uppercased()
// That question mark is optional chaining – if first returns nil then Swift won’t try to uppercase
// it, and will set beatle to nil immediately.

// optional try
// try? changes throwing functions into functions that return an optional. If the function throws an error
// you’ll be sent nil as the result, otherwise you’ll get the return value wrapped as an optional.
if let result = try? checkPassword("password") {
   print("Result was \(result)")
} else {
   print("D'oh.")
}
// The other alternative is try!, which you can use when you know for sure that the function will not fail.
// If the function does throw an error, your code will crash.
try! checkPassword("sekrit")
print("OK!")

// failable initializers
// An initializer that might work or might not. You can write these in your own structs and classes by using
// init?() rather than init(), and return nil if something goes wrong. The return value will then be an optional
// of your type, for you to unwrap however you want.
// As an example, we could code a Person struct that must be created using a nine-letter ID string. If anything
// other than a nine-letter string is used we’ll return nil, otherwise we’ll continue as normal.
struct PersonX1 {
    var id: String
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

// typecasting - Swift must always know the type of each of your variables
class Animal { }
class Fish: Animal { }
class Dogx: Animal {
   func makeNoise() {
      print("Woof!")
   }
}
// We can create a couple of fish and a couple of dogs, and put them into an array, like this:
let pets = [Fish(), Dogx(), Fish(), Dogx()]
// Swift can see both Fish and Dog inherit from the Animal class, so it uses type inference to make pets an array
// of Animal.
// If we want to loop over the pets array and ask all the dogs to bark, we need to perform a typecast: Swift will
// check to see whether each pet is a Dog object, and if it is we can then call makeNoise().
// This uses a new keyword called as?, which returns an optional: it will be nil if the typecast failed, or a
// converted type otherwise.
for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}
