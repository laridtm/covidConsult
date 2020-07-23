//
//  DetailsDataProviderTests.swift
//  COVIDConsultTests
//
//  Created by Vitor Costa on 09/07/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import XCTest
@testable import COVIDConsult
import RealmSwift

class DetailsDataProviderTests: XCTestCase {
    var worker: DetailsWorkerProtocol?
    var dataProvider: DetailsDataProviderProtocol?
    
    override func setUp() {
        dataProvider = DetailsDataProvider(config: Realm.Configuration(inMemoryIdentifier: "inMemory"))
        worker = DetailsWorker(dataProvider: dataProvider)
    }

    override func tearDown() {
        dataProvider = nil
        worker = nil
    }
    
    func testIfAddFuncOfDataProviderIsWorkingCorrectly() {
        let handler: HandlerDatabase = HandlerDatabase(config: Realm.Configuration(inMemoryIdentifier: "inMemory"))
        guard let data = """
        [
        {
        "Country": "South Africa",
        "CountryCode": "ZA",
        "Province": "",
        "City": "",
        "CityCode": "",
        "Lat": "-30.56",
        "Lon": "22.94",
        "Confirmed": 2173,
        "Deaths": 25,
        "Recovered": 410,
        "Active": 1738,
        "Date": "2020-04-13T00:00:00Z"
        },
        {
        "Country":"Brazil",
        "CountryCode":"BR",
        "Province":"",
        "City":"",
        "CityCode":"",
        "Lat":"-14.24",
        "Lon":"-51.93",
        "Confirmed":22318,
        "Deaths":1230,
        "Recovered":173,
        "Active":20915,
        "Date":"2020-04-13T00:00:00Z"
        }
        ]
        """.data(using: .utf8) else { return }
        let countries = worker?.decode(data: data)
        var countriesRealm = [CountryRealm]()
        countries?.forEach { country in
            countriesRealm.append(country.transformToRealmObject())
            handler.add(object: countriesRealm.last!)
        }
        
        let allObjects = handler.retrieveAllObjects(type: CountryRealm.self)
        
        XCTAssertEqual(countries?.count, allObjects.count)
        XCTAssertEqual(countries?[0].country, countriesRealm[0].country)
    }
}
