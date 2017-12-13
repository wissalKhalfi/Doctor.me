//
//  VisitorCount.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 19/04/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import Foundation
import RealmSwift

class VisitorCount: Object {
    dynamic var date: Date = Date()
    dynamic var count: Int = Int(0)
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    
 
   
}
