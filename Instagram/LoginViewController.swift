//
//  LoginViewController.swift
//  Instagram
//
//  Created by 유다연 on 2022/05/10.
//

import UIKit

class LoginViewController: UIViewController {
    
    var email = String()
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 이메일 textfield
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        // Optional
        // 값이 있을 수도 없을 수도
        let text = sender.text ?? ""
        self.email = text
    }
    
    // 비밀번호 textfield
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.password = text
    }
    
    // 로그인 버튼
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        
    }
    
    // 가입하기 버튼
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
    }
}
