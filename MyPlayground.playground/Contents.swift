//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
println("xxxxx")
print("hell")

let f:float_t = 70
let t:Int16 = 50

var tt:Int?
print(tt == nil)

if var ttt = tt {
    print("shit")
}


let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}



let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
print(largest)

var firstForLoop = 0
for i in 0...3 {
    firstForLoop += i
}
print(firstForLoop)


func sumOf(p:Bool, numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    if p == true {
        print(sum)
    }
    return sum
}
sumOf(true, 1, 3)
sumOf(false, 42, 597, 12)

var numbers = [23, 32, 2]

let mappedNumbers = numbers.map { 3 * $0 }
print(mappedNumbers)

func f1(a:String) {
    "shit \(a)"
}


f1("ooo")

class C {
    var a:String
    
    init(a:String) {
        self.a = a
    }
}

var a = C(a: "kkkk")

func externalParamFunction(externalOne internalOne: Int, externalTwo internalTwo: Int) {
    println("externalParamFunction: \(internalOne) : \(internalTwo)")
}

// Requires external parameters

externalParamFunction(externalOne: 1, externalTwo: 4)

func externalInternalShared(#paramOne: Int, #paramTwo: Int) {
    println("externalInternalShared: \(paramOne) : \(paramTwo)")
}

externalInternalShared(paramOne: 1, paramTwo: 4)

enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.Ace
let aceRawValue = ace.rawValue
ace.simpleDescription()

let ran = Rank(rawValue: 11)
ran?.simpleDescription()

enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
    
    func color() -> String {
        switch self {
        case .Spades:
            return "black"
        case .Hearts:
            return "black"
        case .Diamonds:
            return "red"
        case .Clubs:
            return "red"
        }
    }
}
    
let hearts = Suit.Hearts
let heartsDescription = hearts.simpleDescription()


