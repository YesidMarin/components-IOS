//
//  CalculateAgeViewController.swift
//  components-IOS
//
//  Created by Yesid Marin on 2/20/19.
//  Copyright © 2019 UpperDev. All rights reserved.
//

import UIKit

class CalculateAgeViewController: UIViewController {
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var txtDatePicker: CornerRoundedTextField = {
        let txt = CornerRoundedTextField(type: .dateBirthDay, propiertiesType: .medium)
        return txt
    }()
    
    lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.red
        return label
    }()
    
    lazy var viewModel: CalculateAgeViewModel = {
        return CalculateAgeViewModel()
    }()
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        showDatePicker()
    }
    
    private func setupView(){
        view.backgroundColor = UIColor.white
        
        view.addSubview(contentView)
        view.addSubview(txtDatePicker)
        view.addSubview(ageLabel)
        
        contentView.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            maker.right.left.equalToSuperview()
        }
        
        txtDatePicker.snp.makeConstraints { maker in
            maker.top.equalTo(contentView).offset(20)
            maker.left.right.equalToSuperview().inset(26)
            maker.width.equalTo(DefaultSystemComponents.defaultTextFieldHeight)
        }
        
        ageLabel.snp.makeConstraints { maker in
            maker.top.equalTo(txtDatePicker.snp.bottom).offset(25)
            maker.left.right.equalToSuperview().inset(26)
        }
        
    }
    
}

extension CalculateAgeViewController {
    
    func showDatePicker(){
        
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = datePicker
        
    }
    
    @objc func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtDatePicker.text = formatter.string(from: datePicker.date)
        viewModel.getAge(birthDay: datePicker.date)
        if viewModel.validateAge() {
            self.view.endEditing(true)
            ageLabel.text = "You have \(viewModel.customerAge) years old"
        }
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}
