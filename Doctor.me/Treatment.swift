//
//  Treatment.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 15/05/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import Foundation

class Treatment :   NSObject {
    
    var id: Int?
    var name: String?
    var date_debut: Date?
    var date_fin: Date?
    var patient_id: Int?
    var nbr_fois_jour: Int?
    var created_at: Date?
    var updated_at: Date?
    
    
    init (aId: Int?,  Name: String?,  dateDebut: Date?,  dateFin: Date?, id_pat: Int?, nbrFois: Int?, createdAt: Date?) {
        self.id = aId
        self.name = Name
        self.date_debut = dateDebut
        self.date_fin = dateFin
        self.patient_id = id_pat
        self.nbr_fois_jour = nbrFois
        self.created_at = createdAt
        
    }
    
    
    
    override var  description : String {
        return "ID Treatment: \(self.id)" +
            "name: \(self.name)" +
            "id patient: \(self.patient_id)\n" +
            "date debut: \(self.date_debut)\n" +
            "date fin : \(self.date_fin)\n" +
            "nombre de fois par jour : \(self.nbr_fois_jour)\n" +
        "created at : \(self.created_at)\n"
        
        
    }
}
