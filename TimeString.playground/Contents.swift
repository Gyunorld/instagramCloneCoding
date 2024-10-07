import UIKit

extension Date {
    func relativeTimeString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        return dateFormatter.string(from: self)
    }
}

let nowDate = Date()
print(nowDate.description)

print(nowDate.relativeTimeString())
