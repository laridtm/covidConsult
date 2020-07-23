//
//  CountryInfo.swift
//  COVIDConsult
//
//  Created by Larissa Diniz  on 12/06/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import Foundation
import RealmSwift

struct CountryInfo: Codable {
    let country: String
    let slug: String
    let iso2: String
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case slug = "Slug"
        case iso2 = "ISO2"
    }
    
    func toCountryInfoRealm() -> CountryInfoRealm {
        let countryRealm = CountryInfoRealm()
        countryRealm.country = self.country
        countryRealm.slug = self.slug
        countryRealm.iso2 = self.iso2
        return countryRealm
    }
}
