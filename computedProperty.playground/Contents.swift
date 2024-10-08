import UIKit

class Person {
    // Stored property
    let lastName: String
    let firstName: String
    
    // Computed property
    var fullName: String {
        return firstName + lastName
    }
    
    init(lastName: String, firstName: String) {
        self.lastName = lastName
        self.firstName = firstName
    }
//    func fullName() -> String {
//        return firstName + lastName
//    }
}

let person = Person(lastName: "김", firstName: "엘사")
//print(person.fullName())
print(person.fullName)
