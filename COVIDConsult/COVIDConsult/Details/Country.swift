//
//  Country.swift
//  COVIDConsult
//
//  Created by Vitor Costa on 10/06/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import UIKit
import RealmSwift

class Country: Codable {
    var country: String?
    var countryCode: String?
    var province: String?
    var city: String?
    var cityCode: String?
    var lat: String?
    var lon: String?
    var confirmed: Int
    var deaths: Int
    var recovered: Int
    var active: Int
    var date: String?
    
    init(country: String?, countryCode: String?, province: String?, city: String?, cityCode: String?, lat: String?, lon: String?, confirmed: Int, deaths: Int, recovered: Int, active: Int, date: String?) {
        self.country = country
        self.countryCode = countryCode
        self.province = province
        self.city = city
        self.cityCode = cityCode
        self.lat = lat
        self.lon = lon
        self.confirmed = confirmed
        self.deaths = deaths
        self.recovered = recovered
        self.active = active
        self.date = date
    }
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case countryCode = "CountryCode"
        case province = "Province"
        case city = "City"
        case cityCode = "CityCode"
        case lat = "Lat"
        case lon = "Lon"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }
    
    func transformToRealmObject() -> CountryRealm {
        let countryRealm = CountryRealm()
        countryRealm.country = self.country
        countryRealm.countryCode = self.countryCode
        countryRealm.province = self.province
        countryRealm.city = self.city
        countryRealm.cityCode = self.cityCode
        countryRealm.lat = self.lat
        countryRealm.lon = self.lon
        countryRealm.confirmed = self.confirmed
        countryRealm.deaths = self.deaths
        countryRealm.recovered = self.recovered
        countryRealm.active = self.active
        countryRealm.date = self.date
        
        return countryRealm
    }
}
