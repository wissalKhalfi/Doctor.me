//
//  Sensor.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 17/04/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import Foundation



class SensorValue {
    
    var Id_Sensor: Int?
    var SensorVal: Float?
    var SensorCreate: Date?
    var SensorCaptId: Int?
    var SensorPatientId: Int?
    
    
    
    
    required init?(id: Int?,val: Float?, create: Date?, captId: Int?, patId: Int? ) {
        self.Id_Sensor = id
        self.SensorVal = val
        self.SensorCreate = create
        self.SensorCaptId = captId
        self.SensorPatientId = patId
    }
    
    func description() -> String {
        return "Sensor id: \(self.Id_Sensor)" +
            "Sensor value: : \(self.SensorVal)" +
            "Sensor creation : : \(self.SensorCreate)"

        
        
    }
}
