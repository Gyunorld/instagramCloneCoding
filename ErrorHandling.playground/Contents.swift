import UIKit

func tryExample(){
 do {
//        let url = URL(string: "https://www.naver.com")!
        let url = URL(string: "https.naver.com")!
     print("url:", url)
        let data = try Data(contentsOf: url)
        let fileContents = String(data: data, encoding: .utf8)
        print(fileContents)
 } catch {
     print("에러발생 : \(error)")
 }
}

//tryExample()

func tryExample2(){
        let url = URL(string: "https://www.naver.com")!
//        let url = URL(string: "https.naver.com")!
    guard let data = try? Data(contentsOf: url) else {
        print("에러발생")
        return
    }
        print("data:",data)
        let fileContents = String(data: data, encoding: .utf8)
        print(fileContents)
}

//tryExample2()

//func tryExample3(){
////        let url = URL(string: "https://www.naver.com")!
////        let url = URL(string: "https.naver.com")!
//        let data = try? Data(contentsOf: url)
//        let fileContents = String(data: data!, encoding: .utf8)
//        print(fileContents)
//}
//
//tryExample3()

//func tryExample4(){
//        let url = URL(string: "https://www.naver.com")!
////        let url = URL(string: "https.naver.com")!
//        let data = try! Data(contentsOf: url)
//        let fileContents = String(data: data, encoding: .utf8)
//        print(fileContents)
//}
//
//tryExample4()

// Error propagation -> 에러를 상위에서 처리하도록 함
func tryExample5() throws{
        let url = URL(string: "https://www.naver.com")!
//        let url = URL(string: "https.naver.com")!
        let data = try Data(contentsOf: url)
        let fileContents = String(data: data, encoding: .utf8)
        print(fileContents)
}

 try! tryExample5()
