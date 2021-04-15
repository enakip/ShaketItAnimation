//
//  ViewController.swift
//  ShakeItAnmiation
//
//  Created by Emiray Nakip on 16.04.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textfieldName : UITextField!
    @IBOutlet weak var buttonSubmit : UIButton! {
        didSet {
            buttonSubmit.addTarget(self, action: #selector(actionButtonSubmit), for: .touchUpInside)
        }
    }
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTextField()
    }

    private func setupTextField() {
        self.textfieldName.delegate = self
        self.textfieldName.setBorder(color: nil, width: nil)
    }
    
    // MARK: - ACTIONS
    @objc private func actionButtonSubmit() {
        self.textfieldName.resignFirstResponder()
    }

}

// MARK: - TEXT FIELD DELEGATE
extension ViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == textfieldName {
            textField.setBorder(color: nil, width: nil)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == textfieldName {
            
            guard let txt = textField.text else { return }
            
            if txt.checkContainsNumberChar() {
                textField.shakeIt()
                textField.setBorder(color: .red, width: nil)
            }
            
        }
    }
}

// MARK: - EXTENSIONS
extension UIView {
    func shakeIt(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y - 1))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y + 1))
        self.layer.add(animation, forKey: "position")
    }
}

extension String {
    func checkContainsNumberChar() -> Bool {
        let capitalLetterRegEx  = ".*[0-9]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: self)
        return capitalresult
    }
}

extension UITextField {
  
    func setBorder(color : UIColor?, width:CGFloat?) {
        self.layer.cornerRadius = 6.0
        self.layer.borderColor = color?.cgColor ?? UIColor.black.cgColor
        self.layer.borderWidth = width ?? 2.0
    }
    
}

