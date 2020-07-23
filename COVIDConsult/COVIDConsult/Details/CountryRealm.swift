//
//  CountryRealm.swift
//  COVIDConsult
//
//  Created by Vitor Costa on 09/07/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class CountryRealm: Object {
    dynamic var country: String?
    dynamic var countryCode: String?
    dynamic var province: String?
    dynamic var city: String?
    dynamic var cityCode: String?
    dynamic var lat: String?
    dynamic var lon: String?
    dynamic var confirmed: Int = 0
    dynamic var deaths: Int = 0
    dynamic var recovered: Int = 0
    dynamic var active: Int = 0
    dynamic var date: String?
    
    override class func primaryKey() -> String? {
        return "country"
    }
}
