//
//  DetailsDataProvider.swift
//  COVIDConsult
//
//  Created by Vitor Costa on 08/07/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import Foundation
import RealmSwift

protocol DetailsDataProviderProtocol {
    func add(countries: [Country])
}

class DetailsDataProvider: DetailsDataProviderProtocol {
    let config: Realm.Configuration
    
    init(config: Realm.Configuration) {
        self.config = config
    }
    
    func add(countries: [Country]) {
        let handler = HandlerDatabase(config: config)
        let countriesRealm = countries.map { $0.transformToRealmObject() }
        
        countriesRealm.forEach { country in
            handler.add(object: country)
        }
    }
}
