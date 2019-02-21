//
//  CalculateAgeViewModel.swift
//  components-IOS
//
//  Created by Yesid Marin on 2/21/19.
//  Copyright © 2019 UpperDev. All rights reserved.
//

import Foundation

class CalculateAgeViewModel {
    
    var customerAge: Int = 0
    
    func validateAge() -> Bool {
        var isOlder = false
        isOlder = customerAge < 18 ? false : true
    
        return isOlder
    }
    
    func getAge(birthDay date: Date){
        let dateAge = Date(birthDay: date)
        customerAge = dateAge.age
    }
    
}
