//
//  ViewController.swift
//  components-IOS
//
//  Created by Yesid Marin SQDM on 2/6/19.
//  Copyright © 2019 UpperDev. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var mvvmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show places nearby with MVVM example", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(showListPlacesNearby(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var calculateAgeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate Age", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(calculateAgeAction(_:)), for: .touchUpInside)
        return button
    }()
    
    var vcPlaces: PlacesViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view, typically from a nib.
        let mainSb = UIStoryboard(name: "Main", bundle: Bundle.main)
        vcPlaces = mainSb.instantiateViewController(withIdentifier: "PlaceList") as? PlacesViewController
       
        let formatter = DateFormatter()
        let birth = "24/02/1998"
        formatter.dateFormat = "dd/mm/yyyy"
        guard let birthDay = formatter.date(from: birth) else { fatalError() }
        let dob = Date(birthDay: birthDay)
        let age = dob.age
        
    }
    
    private func setupView(){
        view.backgroundColor = UIColor.white
        
        view.addSubview(contentView)
        contentView.addSubview(mvvmButton)
        contentView.addSubview(calculateAgeButton)
        
        contentView.snp.makeConstraints { (maker) in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            maker.right.left.equalToSuperview()
        }
        
        mvvmButton.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().inset(18)
            maker.height.equalTo(15)
            maker.left.right.width.equalToSuperview()
        }
        
        calculateAgeButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(mvvmButton.snp.bottom).offset(18)
            maker.height.equalTo(15)
            maker.left.right.width.equalToSuperview()
        }
        
       
        
    }

    @objc private func showListPlacesNearby (_ sender: UIButton) {
        self.present(vcPlaces!, animated: true, completion: nil)
    }
    
    @objc private func calculateAgeAction(_ sender: UIButton) {
        let calculateAgeViewController = CalculateAgeViewController()
        calculateAgeViewController.title = "Calculate Age"
        navigationController?.pushViewController(calculateAgeViewController, animated: true)
    }

}


extension Date {
    
    var age: Int {
        get {
            let now = Date()
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: self, to: now)
            guard let age = ageComponents.year else { fatalError("Not found age")}
            return age
        }
    }
    
    init(birthDay: Date) {
        var birh = Date()
        birh = birthDay
        self.init(timeInterval: 0, since: birh)
    }
    
}

