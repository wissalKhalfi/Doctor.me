//
//  GlucoGenerator.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 17/04/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import Foundation

struct Sale {
    var month: String
    var value: Double
}

class GlucoGenerator {
    
    static var randomizedSale: Double {
        return Double(arc4random_uniform(10000) + 1) / 10
    }
    
    static func data() -> [Sale] {
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        var sales = [Sale]()
        
        for month in months {
            let sale = Sale(month: month, value: randomizedSale)
            sales.append(sale)
        }
        
        return sales
    }
}
