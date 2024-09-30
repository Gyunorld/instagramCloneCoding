//
//  ViewController.swift
//  MVCTutorial
//
//  Created by 김민규 on 9/30/24.
//

import UIKit

import UIKit

// Model (Data 관리)
struct NumberModel {
    var number: Int
}

// View
class MyView: UIView {
    let numberLabel = UILabel() //UIKit에서는 Text뷰를 UILabel이라고 함
    var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("증가", for: .normal)
//        button.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func addViews() {
        //Label(텍스트)와 Button을 뷰에 넣기
        addSubview(numberLabel)
        addSubview(plusButton)
    }
    
    func arrangeViews() {
        //Label(텍스트)와 Button 위치 설정
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            plusButton.widthAnchor.constraint(equalToConstant: 100),
            plusButton.heightAnchor.constraint(equalToConstant: 50),
            plusButton.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 5),
            plusButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])

    }
}

class ViewController: UIViewController {
//    var number: Int = 0
    
    var model = NumberModel(number: 0)
    var myView = MyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMyView()
        myView.plusButton.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        
        updateLabel() //뷰 초기화
    }
    
    func addMyView() {
        self.view.addSubview(myView)
        myView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            myView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            myView.widthAnchor.constraint(equalToConstant: 150),
            myView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
  
    
    @objc func buttonTouched() {
        plusLogic()
        updateLabel()
    }
    
    func updateLabel() {
        myView.numberLabel.text = "\(model.number)"
    }
    
    func plusLogic() {
        if model.number % 2 == 0 { //2로 나누어서 나머지가 0이면 = 짝수이면
            model.number += 1
        } else { //홀수이면
            model.number *= 2

        }
    }
}
