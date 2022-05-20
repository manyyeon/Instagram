//
//  RegisterViewController.swift
//  Instagram
//
//  Created by 유다연 on 2022/05/10.
//

import UIKit

class RegisterViewController: UIViewController {
    // MARK: - Properties
    var email: String = ""
    var name: String = ""
    var nickname: String = ""
    var password: String = ""
    
    var userInfo: ((UserInfo) -> Void)?
    
    
    // 유효성 검사를 위한 프로퍼티
    var isValidEmail = false {
        didSet { // 프로퍼티 옵저버
            // 이 값이 변경될 때마다 유효성 검사 로직이 실행될 것임
            self.validateUserInfo()
        }
    }
    
    var isValidName = false {
        didSet { // 프로퍼티 옵저버
            self.validateUserInfo()
        }
    }
    
    var isValidNickname = false {
        didSet { // 프로퍼티 옵저버
            self.validateUserInfo()
        }
    }
    
    var isValidPassword = false {
        didSet { // 프로퍼티 옵저버
            self.validateUserInfo()
        }
    }
    
    @IBOutlet weak var popToLoginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
    // Textfields
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var textFields: [UITextField] {
        [emailTextField, nameTextField, nicknameTextField, passwordTextField]
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupAttribute()
        
        // bug fix
        self.navigationController?
            .interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - Actions
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        switch sender {
        case emailTextField:
            self.isValidEmail = text.isValidEmail()
            self.email = text
            
        case nameTextField:
            self.isValidName = text.count > 2
            self.name = text
            
        case nicknameTextField:
            self.isValidNickname = text.count > 2
            self.nickname = text
            
        case passwordTextField:
            self.isValidPassword = text.isValidPassword()
            self.password = text
            
        default:
            fatalError("Missing TextField...")
        }
    }
    
    @IBAction func backButtonDidTap(_ sender: UIBarButtonItem) {
        // 뒤로가기
        // LoginViewController에서 pushViewController를 썼다면 여기선 반대로 popViewController를 사용
        self.navigationController?
            .popViewController(animated: true) // 이전화면으로 돌아가기
    }
    
    
    @IBAction func registerButtonDidtap(_ sender: UIButton) {
        // 뒤로가기
        self.navigationController?
            .popViewController(animated: true) // 이전화면으로 돌아가기
        
        let userInfo = UserInfo(
            email: self.email,
            name: self.name,
            nickname: self.nickname,
            password: self.password
        )
        self.userInfo?(userInfo)
    }
    
    // MARK: - Helpers
    private func setupTextField() {
        textFields.forEach() { tf in
            // emailTextField에 이벤트가 오면
            // target은 누가 처리할거냐, action: 어디서 처리할거냐, for: 어떤 이벤트에 대해 처리할거냐
            tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        }
    }
    
    // 사용자가 입력한 회원 정보를 입력하고 -> UI 업데이트
    private func validateUserInfo() {
        
        if isValidEmail
            && isValidName
            && isValidNickname
            && isValidPassword {
            
            self.signupButton.isEnabled = true // 버튼이 눌리게
            // 애니매이션 넣기
            UIView.animate(withDuration: 0.33) {
                self.signupButton.backgroundColor = UIColor.facebookColor
            }
        } else {
            UIView.animate(withDuration: 0.33) {
                self.signupButton.isEnabled = false // 버튼이 안눌리게
                self.signupButton.backgroundColor = .disabledButtonColor
            }
        }
    }
    
    private func setupAttribute() {
        // registerButton
        let text1 = "계정이 있으신가요?"
        let text2 = "로그인"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor.facebookColor
        
        let attributes = generateButtonAttribute(self.popToLoginButton, texts: text1, text2, fonts: font1, font2, colors: color1, color2)
        
        self.popToLoginButton.setAttributedTitle(attributes, for: .normal)
    }
}

// 정규표현식
extension String{
    // 대문자, 소문자, 특수문자, 숫자 8자 이상일 때, -> True
    func isValidPassword() -> Bool {
        let reqularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", reqularExpression)
        return passwordValidation.evaluate(with: self)
    }
    
    // @ 2글자
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
