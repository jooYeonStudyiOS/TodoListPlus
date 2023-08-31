//
//  UISetpProtocol.swift
//  TodoListPlus
//
//  Created by Jooyeon Kang on 2023/08/31.
//

import UIKit

protocol UISetupProtocol {
    func setup(to textField: UITextField)
    func setup(to detaPicker: UIDatePicker)
    func setup(to textView: UITextView)
}

extension UISetupProtocol {
    func setup(to textField: UITextField) {
        textField.placeholder = "필수항목 입니다"
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor =  UIColor.black.cgColor
        textField.layer.cornerRadius = 5
    }
    
    func setup(to detaPicker: UIDatePicker){
        detaPicker.isHidden = true
    }
    
    func setup(to textView: UITextView){
        textView.layer.borderWidth = 1
        textView.layer.borderColor =  UIColor.black.cgColor
        textView.layer.cornerRadius = 5
    }
}

