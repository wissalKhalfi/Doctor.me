//
//  user.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 16/04/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import Foundation


class Patient:   NSObject, NSCoding {
    
    var id: Int?
    var FirstName: String?
    var LastName: String?
    var Email: String?
    var Phone: Int?
    var Cin: Int?
    var sexe: String?
    var groupe_sanguin : String?
    var Poids: Int?
    var Taille: Int?
    var DocId: Int?
    var Password: String?
    var capteur1: Int?
    var capteur2: Int?
    var capteur3: Int?
    var capteur4: Int?
    var capteur5: Int?
    var capteur6: Int?
    var capteur7: Int?
    
    
    init?(aId: Int?, aFN: String?,aLN: String?, Email:String? , Phone: Int?, Cin: Int?, sexe: String?,  grp_sanguin : String?, Poids: Int?, Taille: Int?, DocId: Int?, password: String?,  capteur1: Int? ,capteur2: Int? , capteur3: Int? , capteur4: Int? , capteur5: Int? , capteur6: Int? ,capteur7: Int?) {
        self.id = aId
        self.FirstName = aFN
        self.LastName = aLN
        self.Email = Email
        self.Phone = Phone
        self.Cin = Cin
        self.sexe = sexe
        self.groupe_sanguin = grp_sanguin
        self.Poids = Poids
        self.Taille = Taille
        self.DocId = DocId
        self.Password = password
        self.capteur1 = capteur1
        self.capteur2 = capteur2
        self.capteur3 = capteur3
        self.capteur4 = capteur4
        self.capteur5 = capteur5
        self.capteur6 = capteur6
        self.capteur7 = capteur7
        
        
    }
    required init(coder decoder: NSCoder) {
        self.id = decoder.decodeInteger(forKey: "id")
        self.FirstName = decoder.decodeObject(forKey: "FirstName") as? String
        self.LastName = decoder.decodeObject(forKey: "LastName") as? String
        self.Email = decoder.decodeObject(forKey: "Email") as? String
        self.Phone = decoder.decodeInteger(forKey: "Phone")
        self.Cin = decoder.decodeInteger(forKey: "Cin")
        self.sexe = decoder.decodeObject(forKey: "sexe") as? String
        self.groupe_sanguin = decoder.decodeObject(forKey: "groupe_sanguin") as? String
        self.Poids = decoder.decodeInteger(forKey: "Poids")
        self.Taille = decoder.decodeInteger(forKey: "Taille")
        self.DocId = decoder.decodeInteger(forKey: "DocId")
        self.Password = decoder.decodeObject(forKey: "Password") as? String
        self.capteur1 = decoder.decodeInteger(forKey: "capteur1")
        self.capteur2 = decoder.decodeInteger(forKey: "capteur2")
        self.capteur3 = decoder.decodeInteger(forKey: "capteur3")
        self.capteur4 = decoder.decodeInteger(forKey: "capteur4")
        self.capteur5 = decoder.decodeInteger(forKey: "capteur5")
        self.capteur6 = decoder.decodeInteger(forKey: "capteur6")
        self.capteur7 = decoder.decodeInteger(forKey: "capteur7")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id!, forKey: "id")
        aCoder.encode(self.FirstName, forKey: "FirstName")
        aCoder.encode(self.LastName, forKey: "LastName")
        aCoder.encode(self.Email, forKey: "Email")
        aCoder.encode(self.Phone!, forKey: "Phone")
        aCoder.encode(self.Cin!, forKey: "Cin")
        aCoder.encode(self.sexe!, forKey: "sexe")
        aCoder.encode(self.groupe_sanguin!, forKey: "groupe_sanguin")
        aCoder.encode(self.Poids!, forKey: "Poids")
        aCoder.encode(self.Taille!, forKey: "Taille")
        aCoder.encode(self.DocId!, forKey: "DocId")
        aCoder.encode(self.Password, forKey: "Password")
        aCoder.encode(self.capteur1!, forKey: "capteur1")
        aCoder.encode(self.capteur2!, forKey: "capteur2")
        aCoder.encode(self.capteur3!, forKey: "capteur3")
        aCoder.encode(self.capteur4!, forKey: "capteur4")
        aCoder.encode(self.capteur5!, forKey: "capteur5")
        aCoder.encode(self.capteur6!, forKey: "capteur6")
        aCoder.encode(self.capteur7!, forKey: "capteur7")
        
    }
    
    override var  description : String {
        return "ID patient: \(self.id)" +
            "User First Name: \(self.FirstName)" +
            "Last Name: \(self.LastName)\n" +
            "Email: \(self.Email)\n" +
            "Password: \(self.Password)\n"


    }
}
