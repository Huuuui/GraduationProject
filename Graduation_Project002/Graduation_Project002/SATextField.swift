//
//  SATextField.swift
//
//  Created by valvoline on 26/06/2019.
//  Modified by David Chen
//  Copyright © 2019 Costantino Pistagna. All rights reserved.
//

import SwiftUI

class WrappableTextField: UITextField, UITextFieldDelegate {
    var textFieldChangedHandler: ((String)->Void)?
    var onCommitHandler: (()->Void)?
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentValue = textField.text as NSString? {
            let proposedValue = currentValue.replacingCharacters(in: range, with: string)
            textFieldChangedHandler?(proposedValue as String)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        onCommitHandler?()
    }
}
struct SATextField1: UIViewRepresentable {
    private let tmpView = WrappableTextField()
    
    var tag:Int = 0
    var text:String?
    var placeholder:String?
    var textColor: Color?
    var changeHandler:((String)->Void)?
    var onCommitHandler:(()->Void)?
    
    func makeUIView(context: UIViewRepresentableContext<SATextField1>) -> WrappableTextField {
        tmpView.tag = tag
        tmpView.delegate = tmpView
        tmpView.font = UIFont.systemFont(ofSize: 18)
        tmpView.text = text
        tmpView.placeholder = placeholder
        tmpView.onCommitHandler = onCommitHandler
        tmpView.textFieldChangedHandler = changeHandler
        tmpView.borderStyle = UITextField.BorderStyle.roundedRect
        tmpView.textAlignment = .center
        //tmpView.clearButtonMode=UITextField.ViewMode.whileEditing
        
        return tmpView
    }
    
    func updateUIView(_ uiView: WrappableTextField, context: UIViewRepresentableContext<SATextField1>) {
        
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}
struct SATextField: UIViewRepresentable {
    private let tmpView = WrappableTextField()
    
    var tag:Int = 0
    var text:String?
    var placeholder:String?
    var textColor: Color?
    var changeHandler:((String)->Void)?
    var onCommitHandler:(()->Void)?
    
    func makeUIView(context: UIViewRepresentableContext<SATextField>) -> WrappableTextField {
        tmpView.tag = tag
        tmpView.delegate = tmpView
        tmpView.font = UIFont.systemFont(ofSize: 18)
        tmpView.text = text
        tmpView.placeholder = placeholder
        tmpView.onCommitHandler = onCommitHandler
        tmpView.textFieldChangedHandler = changeHandler
        tmpView.borderStyle = UITextField.BorderStyle.roundedRect
        return tmpView
    }
    
    func updateUIView(_ uiView: WrappableTextField, context: UIViewRepresentableContext<SATextField>) {
        
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}
