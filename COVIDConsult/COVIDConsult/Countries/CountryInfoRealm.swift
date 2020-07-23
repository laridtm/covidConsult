//
//  CountryInfoRealm.swift
//  COVIDConsult
//
//  Created by Larissa Diniz  on 03/07/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import Foundation
import RealmSwift

class CountryInfoRealm: Object {
    @objc dynamic var country = ""
    @objc dynamic var slug = ""
    @objc dynamic var iso2 = ""
    
    override static func primaryKey() -> String? {
        return "iso2"
    }
}
