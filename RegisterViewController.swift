//
//  RegisterViewController.swift
//  Instagram
//
//  Created by 유다연 on 2022/05/10.
//

import UIKit

class RegisterViewController: UIViewController {
    // MARK: - Properties
    // 유효성 검사를 위한 프로퍼티
    var isValidEmail = false
    
    var isValidName = false
    
    var isValidNickname = false
    
    var isValidPassword = false
    
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
    }
    
    // MARK: - Actions
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        switch sender {
        case emailTextField:
            print("email")
        case nameTextField:
            print("name")
        case nicknameTextField:
            print("nickname")
        case passwordTextField:
            print("password")
        default:
            fatalError("Missing TextField...")
        }
    }
    
    // MARK: - Helpers
    private func setupTextField() {
        textFields.forEach() { tf in
            // emailTextField에 이벤트가 오면
            // target은 누가 처리할거냐, action: 어디서 처리할거냐, for: 어떤 이벤트에 대해 처리할거냐
            tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        }
    }
}
