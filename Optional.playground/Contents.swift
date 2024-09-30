import UIKit

// Optional, Optional Unwrapping

let number1 : Int = 10
let number2 : Int? = nil
let number3 : Int? = 3

func square(number: Int) {
    print("\(number)의 제곱값은 \(number * number)입니다.")
}

square(number: number1)

// Optional Unwrapping
// 1. nil-coalescing -> 기본값 넣어주기

square(number: number2 ?? 0) // number2가 nil이면 0으로 해라
square(number: number3 ?? 0) // number2가 nil이면 0으로 해라

print("------2. forced-unwrapping -> 위험하게 벗기기------")
// 2. forced-unwrapping -> 위험하게 벗기기

//square(number: number2!)    // 앱에서 사용시 충돌발생
square(number: number3!)

print("------3. optional binding1(if-let) -> 조심히 벗기기1------")
// 3. optional binding1(if-let) -> 조심히 벗기기1
if let num = number2 {
    square(number: num)
} else {
    print("언래핑 실패!")
}

print("------4. optional binding2(guard-let) -> 조심히 벗기기2------")
// 4. optional binding2(guard-let) -> 조심히 벗기기2
func guardLetExample() {
    guard let num = number2 else {
        print("guard-let 언래핑 실패!")
        return
    }
    square(number: num)
}
guardLetExample()
