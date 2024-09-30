import UIKit

//print("시작")
//print("1.쓰레드:", Thread.current)
//
//Task {
//    print("2.쓰레드:", Thread.current)
//    // Asynchronous(비동기) == ajax
//    var number = 0
//    for i in 1...10000 {
//        //    number = number + i
//        number += i
//    }
//    print("결과:", number)
//}
//
//print("끝")

// 오래된 함수인지 아는 방법
Task{
    print("시작")
    await Task.sleep(2_000_000_000)
    print("끝")
}
