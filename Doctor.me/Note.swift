//
//  Note.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 29/04/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import Foundation
class NotePatient :   NSObject {
    
    var id: Int?
    var idDoc: Int?
    var idPat: Int?
    var remarque: String?
    var dateR: String?
    
    
    
    init (aId: Int?, id_doc: Int?,id_pat: Int?, req:String?, date_rq: String?) {
        self.id = aId
        self.idDoc = id_doc
        self.idPat = id_pat
        self.remarque = req
        self.dateR = date_rq
        
    }
    

    
    override var  description : String {
        return "ID note: \(self.id)" +
            "id doctor: \(self.idDoc)" +
            "id patient: \(self.idPat)\n" +
            "remarque: \(self.remarque)\n" +
            "date : \(self.dateR)\n"
        
        
}
}


 
