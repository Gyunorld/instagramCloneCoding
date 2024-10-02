import UIKit

// static

class Car {
    var carname = "포르쉐"
    func printCarName() {
        print("차 이름은 \(carname)입니다.")
    }
    
    static var carBrand = ["현대", "포르쉐", "BMW"]
    static func randomBrand() {
        let brand = carBrand.randomElement()
        print("랜덤으로 고른 브랜드 :", brand)
    }
}

let car = Car()
car.carname
car.printCarName()

Car.carBrand
Car.randomBrand()


// Singleton => 데이터를 한가지만 사용하고 싶을 때 사용함
class Person {
    var username = "범블비"
}

let person1 = Person()
person1.username = "옵티머스 프라임"
print(person1.username)

let person2 = Person()
print(person2.username)

class Dog {
    var name = "멍멍이"
    static let shared = Dog()
}

let dog1 = Dog.shared
dog1.name = "야옹이"

let dog2 = Dog.shared
print(dog2.name)

