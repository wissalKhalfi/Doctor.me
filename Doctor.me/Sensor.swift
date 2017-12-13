//
//  Sensor.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 17/04/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import Foundation



class Sensor {
    
    var SensorName: String?
    var SensorActive: Int?
    var SensorId: Int?
    
    
    
    required init?(aFN: String?,aActive: Int?, aId: Int? ) {
        self.SensorName = aFN
        self.SensorActive = aActive
        self.SensorId = aId
    }
    
    func description() -> String {
        return "Sensor name: \(self.SensorName)" +
            "Sensor is active: : \(self.SensorActive)" +
            "Sensor id: : \(self.SensorId)"

        
        
    }
}
