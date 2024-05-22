//
//  bmiCalculatorViewController.swift
//  bmiCalculator
//
//  Created by 홍석평 on 5/21/24.
//

import UIKit

class bmiCalculatorViewController: UIViewController {
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    @IBOutlet var mainImage: UIImageView!
    
    @IBOutlet var nickNameTextField: UITextField!
    
    @IBOutlet var bodyHeightLabel: UILabel!
    @IBOutlet var bodyHeightTextField: UITextField!
    
    @IBOutlet var bodyWeightLabel: UILabel!
    @IBOutlet var bodyWeightTextField: UITextField!
    
    @IBOutlet var randomBmiButton: UIButton!
    
    @IBOutlet var bodyResultButton: UIButton!
  
    @IBOutlet var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // userDefaults로 저장한 내용 가져오기
        let nickName = UserDefaults.standard.string(forKey: "nickName")
        nickNameTextField.text = nickName
        
        let bodyHeight = UserDefaults.standard.string(forKey: "bodyHeight")
        bodyHeightTextField.text = bodyHeight
        
        let bodyWeight = UserDefaults.standard.string(forKey: "bodyWeight")
        bodyWeightTextField.text = bodyWeight
        
        titleLabel.text = "BMI Calculator"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = "당신의 BMI 지수를 \n알려드릴게요"
        
        mainImage.image = UIImage(named: "image")
        
        nickNameTextField.placeholder = "닉네임을 입력해주세요"
        nickNameTextField.font = .systemFont(ofSize: 24)
        
        bodyHeightLabel.text = "키가 어떻게 되시나요?"
        bodyWeightLabel.text = "몸무게는 어떻게 되시나요?"
        
        textFieldSet(bodyHeightTextField)
        textFieldSet(bodyWeightTextField)
        
        randomBmiButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomBmiButton.setTitleColor(.red, for: .normal)
        
        buttonSet(bodyResultButton, "결과 확인")
        buttonSet(resetButton, "RESET")
        
      
    }
    
    // 버튼 세팅
    func buttonSet(_ button: UIButton,_ buttonSetTitle: String){
        
        button.setTitle(buttonSetTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        
    }
    
   
    // 결과 확인 버튼
    // alert를 사용 -> bmi 결과 보여줌 (취소 버튼 1개)
    @IBAction func resultButtonClicked(_ sender: UIButton){
        
        var bmi = 0.0
        var bmiResult: String
        
        guard let height = Double(bodyHeightTextField.text!) , let weight = Double(bodyWeightTextField.text!) else {
            return alertMessage("경고","숫자만 입력해주세요")
        }
        bmi = weight / (height * height * 0.0001)
        
        switch bmi {
        case 0.0 ..< 18.5:
            bmiResult = " 저체중"
        case 18.5 ..< 25.0:
            bmiResult = " 정상체중"
        case 25.0 ..< 30.0:
            bmiResult = " 비만 전단계"
        case 30.0 ..< 35.0:
            bmiResult = " 경도 비만"
        case 35.0 ..< 40.0:
            bmiResult = " 중등도 비만"
        default: // 40 이상
            bmiResult = " 고도 비만"
        }
        // bmi 소수점 반올림
        bmiResult = String(round(bmi)) + bmiResult
        alertMessage("BMI결과",bmiResult)
        
        
        // 닉네임, 키, 몸무게 저장하기
        UserDefaults.standard.set(nickNameTextField.text, forKey: "nickName")
        UserDefaults.standard.set(bodyHeightTextField.text, forKey: "bodyHeight")
        UserDefaults.standard.set(bodyWeightTextField.text, forKey: "bodyWeight")
        
    }
    
    @IBAction func randomButtonClicked(_ sender: UIButton)  {
        alertMessage("랜덤 BMI",randomBmiCalculator())
       
    }
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "nickName")
        UserDefaults.standard.removeObject(forKey: "bodyHeight")
        UserDefaults.standard.removeObject(forKey: "bodyWeight")
        
        let nickName = UserDefaults.standard.string(forKey: "nickName")
        nickNameTextField.text = nickName
        
        let bodyHeight = UserDefaults.standard.string(forKey: "bodyHeight")
        bodyHeightTextField.text = bodyHeight
        
        let bodyWeight = UserDefaults.standard.string(forKey: "bodyWeight")
        bodyWeightTextField.text = bodyWeight
        
        
    }
    func randomBmiCalculator () -> String  {
        
        var randomBmiResult: String
        // 키는 160이상 180이하
        let randomHeight = Double.random(in: 160...180)
        // 몸무게는 40이상 100이하
        let randomWeight = Double.random(in: 40...100)
        
        let bmi = randomWeight / (randomHeight * randomHeight * 0.0001)
       
        switch bmi {
        case 0.0 ..< 18.5:
            randomBmiResult = " 저체중"
        case 18.5 ..< 25.0:
            randomBmiResult = " 정상체중"
        case 25.0 ..< 30.0:
            randomBmiResult = " 비만 전단계"
        case 30.0 ..< 35.0:
            randomBmiResult = " 경도 비만"
        case 35.0 ..< 40.0:
            randomBmiResult = " 중등도 비만"
        default: // 40 이상
            randomBmiResult = " 고도 비만"
        }
        // bmi 소수점 반올림
        randomBmiResult = String(round(bmi)) + randomBmiResult
        return randomBmiResult
        
    }
    
    
  
   
    
    
    // alert 설정 메시지
    func alertMessage(_ mainTitleMessage: String,_ subTitleMessage: String){
        
        // 1) alert창 제목, 메세지 설정
        let alert = UIAlertController(title: mainTitleMessage, message: "\(subTitleMessage)", preferredStyle: .alert)
        
        // 2) 버튼 생성
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        // 3) 버튼 생성
        alert.addAction(cancel)
        
        // 4) 버튼 보여주기
        present(alert, animated: true)
        
    }
   
    // 텍스트 필드 설정
    func textFieldSet(_ textField: UITextField){
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    // 제스처로 키보드 숨기기
    @IBAction func keyBoardDissmiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    
    // Double로 리턴
//    func bmiCalculate () -> String {
//
//        var bmi = 0.0
//        var bmiResult: String
//
//        guard let height = bodyHeightTextField.text , let weight = bodyWeightTextField.text else{
//            alertMessage(bmiCalculate())
//        }
//
//        if let height = Double(bodyHeightTextField.text!), let weight = Double(bodyWeightTextField.text!){
//
//            bmi = weight / (height * height * 0.0001)
//
//            // 문자열 입력 받았을때
//        } else if bodyWeightTextField.text == "" && bodyHeightTextField.text == "" {
//            // alert로 대응
//
//        } else {
//
//        }
//
        //var height = Double(bodyHeightTextField.text!)!
       // var weight = Double(bodyWeightTextField.text!)!
       
//        switch bmi {
//        case 0.0 ..< 18.5:
//            bmiResult = " 저체중"
//        case 18.5 ..< 25.0:
//            bmiResult = " 정상체중"
//        case 25.0 ..< 30.0:
//            bmiResult = " 비만 전단계"
//        case 30.0 ..< 35.0:
//            bmiResult = " 경도 비만"
//        case 35.0 ..< 40.0:
//            bmiResult = " 중등도 비만"
//        default: // 40 이상
//            bmiResult = " 고도 비만"
//        }
//        // bmi 소수점 반올림
//        bmiResult = String(round(bmi)) + bmiResult
//        return bmiResult
//    }
//
    
    // 함수 매개변수로 alert 함수 받기 포기 ..
//    func bmiResultAlert (_ bmiMessage: ()) {
//        // 1) alert창 제목, 메세지 설정
//        let alert = UIAlertController(title: "BMI 결과", message: "\(bmiMessage)", preferredStyle: .alert)
//
//        // 2) 버튼 생성
//        let cancel = UIAlertAction(title: "취소", style: .cancel)
//
//        // 3) 버튼 생성
//        alert.addAction(cancel)
//
//        // 4) 버튼 보여주기
//        present(alert, animated: true)
//
//    }
    //    @IBAction func bodyHeightTextFieldEditChanged(_ sender: UITextField) {
    //
    //        let text = sender.text ?? ""
    //
    //        if Double(text) != nil {
    //
    //            let value = Double(text)!
    //
    //            bodyHeightTextField.text = "\(value)"
    //
    //        } else {
    //            let alert = UIAlertController(title: "알림    ", message: "문자 입력은 불가능합니다!", preferredStyle: .alert)
    //
    //            let cancel = UIAlertAction(title: "취소", style: .cancel)
    //
    //            alert.addAction(cancel)
    //
    //            present(alert, animated: true)
    //        }
    //
    //
    //
    //
    //    }
    //
}
