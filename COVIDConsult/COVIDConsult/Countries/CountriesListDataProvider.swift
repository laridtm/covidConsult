//
//  CountriesListDataProvider.swift
//  COVIDConsult
//
//  Created by Larissa Diniz  on 03/07/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import Foundation
import RealmSwift

class CountriesListDataProvider {
    let config: Realm.Configuration
    
    init(config: Realm.Configuration) {
        self.config = config
    }

    func add(countries: [CountryInfo]) {
        let handler = HandlerDatabase(config: config)
        var countriesRealm: [CountryInfoRealm] = []
        countriesRealm = countries.map { $0.toCountryInfoRealm() }

        countriesRealm.forEach { country in
            handler.add(object: country)
        }
    }
}
