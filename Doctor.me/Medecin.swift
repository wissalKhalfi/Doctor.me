//
//  user.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 16/04/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import Foundation


class Medecin:   NSObject, NSCoding {
    
    var id: Int?
    var Name: String?
    var Email: String?
    var Password: String?

    
    
    init (aId: Int?, aFN: String?, Email:String?, pass: String?) {
        self.id = aId
        self.Name = aFN
        self.Email = Email
        self.Password = pass
        
    }
    
    
    required init(coder decoder: NSCoder) {
        self.id = decoder.decodeInteger(forKey: "id")
        self.Name = decoder.decodeObject(forKey: "Name") as? String
        self.Email = decoder.decodeObject(forKey: "Email") as? String
        self.Password = decoder.decodeObject(forKey: "Password") as? String
    }
    

    
    func encode(with aCoder: NSCoder) {
        //coder.encode(name, forKey: "name")
        //coder.encode(age, forKey: "age")
        aCoder.encode(self.id!, forKey: "id")
        //aCoder.encode(id!, forKey: "id")
        aCoder.encode(self.Name, forKey: "Name")
        aCoder.encode(self.Email, forKey: "Email")
        aCoder.encode(self.Password, forKey: "Password")
    }
    
    
    override var  description : String {
        return "ID doctor: \(self.id)" +
            "Last Name: \(self.Name)\n" +
            "Email: \(self.Email)\n" +
            "Password: \(self.Password)\n"


    }
    
    
  
  
}
