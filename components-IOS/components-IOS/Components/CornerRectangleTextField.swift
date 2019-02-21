//
//  CornerRoundedTextField.swift
//  components-IOS
//
//  Created by Yesid Marin on 2/21/19.
//  Copyright © 2019 UpperDev. All rights reserved.
//

import UIKit

enum CornerRoundedTextFieldType {
    case dateBirthDay
    
    var placeholderTextField: String {
        switch self {
        case .dateBirthDay:
            return "Select your birthdate"
        }
    }
}

class CornerRoundedTextField: UITextField {
    
    let padding = DefaultSystemComponents.defaultPaddingTextFieldAndButtons
    let type: CornerRoundedTextFieldType
    let propiertiesType: TextFieldStyle
    
    init(type: CornerRoundedTextFieldType, propiertiesType: TextFieldStyle) {
        self.type = type
        self.propiertiesType = propiertiesType
        super.init(frame: .zero)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var placeholder: String? {
        didSet {
            changePlaceHolderProperties(text: placeholder)
        }
    }
    
    private func initView() {
        layer.borderColor = Colors.lightGray.cgColor
        setValue(Colors.blueGray, forKeyPath: "_placeholderLabel.textColor")
        layer.cornerRadius =  5
        layer.borderWidth = 1
        backgroundColor = Colors.white
        
        let propierties = propiertiesType.properties
        tintColor = propierties.cursorColor
        font = UIFont.systemFont(ofSize: propierties.fontSize, weight: propierties.fontWeight)
        textColor = propierties.textColor
        delegate = self
        placeholder = type.placeholderTextField
        autocorrectionType = .no
        
        switch type {
        case .dateBirthDay:
            isSecureTextEntry = false
        }
        
    }
    
    private func changePlaceHolderProperties(text: String?) {
        guard let placeHolderText = text else { return }
        let properties = propiertiesType.properties
        
        let mutableStringTitle = NSMutableAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: properties.fontSize, weight: properties.fontWeight)])
        mutableStringTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: properties.placeHolderColor, range: NSRange(location: 0,length:  placeHolderText.count))
        attributedPlaceholder = mutableStringTitle
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}

extension CornerRoundedTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor =  Colors.blueGray.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.layer.borderColor =  Colors.lightGray.cgColor
    }
    
    // Can not use actions
    override func canPerformAction(_ action: Selector, withSender sender:  Any?) -> Bool {
        if action == #selector(select(_:)) || action == #selector(selectAll(_:))  || action == #selector(cut(_:)) || action == #selector(copy(_:))  || action == #selector(paste(_:)) || action == #selector(delete(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
}
