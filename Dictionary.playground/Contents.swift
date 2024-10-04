import UIKit

let array = ["aggma", "apple", "battle ground"]
print(array[0])
print(array[1])
print(array[2])

var dictionary: [String : String] = ["name": "aggma", "fruit": "apple", "game": "battle ground"]
let dictionary2: [String : Int] = ["name": 1, "fruit": 3, "game": 6]
// 다른 언어와 통신 할 때 주로 사용
// dictionary = JSON과 유사함

print(dictionary["name"])
print(dictionary["fruit"])
print(dictionary["game"])
print(dictionary["age"])
dictionary["song"] = "love wins all"
print(dictionary["song"])

print(dictionary2["name"])

struct Person {
    let name: String
    let fruit: String
    let game: String
}

let person: Person = .init(name: "aggma", fruit: "apple", game: "battle ground")
print(person.name)
print(person.fruit)
print(person.game)
