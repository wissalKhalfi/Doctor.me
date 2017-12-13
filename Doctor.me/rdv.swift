//
//  rdv.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 29/04/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import Foundation


class RDV :   NSObject {
    
    var id: Int?
    var idDoc: Int?
    var idPat: Int?
    var etat: Int?
    var dateRdv: String?
    
    
    
    init (aId: Int?, id_doc: Int?,id_pat: Int?, et:Int?, date_rq: String?) {
        self.id = aId
        self.idDoc = id_doc
        self.idPat = id_pat
        self.etat = et
        self.dateRdv = date_rq
        
    }
    
    
    
    override var  description : String {
        return "ID rdv: \(self.id)" +
            "id doctor: \(self.idDoc)" +
            "id patient: \(self.idPat)\n" +
            "etat: \(self.etat)\n" +
        "date : \(self.dateRdv)\n"
        
        
    }
}
