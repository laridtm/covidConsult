//
//  HandlerDatabase.swift
//  COVIDConsult
//
//  Created by Larissa Diniz  on 03/07/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import Foundation
import RealmSwift

class HandlerDatabase {
    let realm: Realm
    
    init(config: Realm.Configuration) {
        do {
            self.realm = try Realm(configuration: config)
        } catch let error as NSError {
            
            self.realm = try! Realm()
        }
    }
    
    func add(object: Object) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch let error as NSError {
            
        }
    }
    
    func retrieveAllObjects(type: Object.Type) -> [Object] {
        var allObjects: [Object] = []
        let realmResults = realm.objects(type)
        
        for object in realmResults {
            allObjects.append(object)
        }
        return allObjects
    }
}
