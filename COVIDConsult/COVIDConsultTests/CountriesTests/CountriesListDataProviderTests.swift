//
//  CountriesListDataProviderTests.swift
//  COVIDConsultTests
//
//  Created by Larissa Diniz  on 03/07/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import Foundation
import XCTest
@testable import COVIDConsult
import RealmSwift

class CountriesListDataProviderTests: XCTestCase {
    
    var worker: CountriesListWorker?
    var dataProvider: CountriesListDataProvider?
    
    override func setUp() {
        super.setUp()
        dataProvider = CountriesListDataProvider(config: Realm.Configuration(inMemoryIdentifier: "inMemory"))
        if let dataProvider = dataProvider {
            worker = CountriesListWorker(dataProvider: dataProvider)
        }
    }
    
    override func tearDown() {
        super.tearDown()
        worker = nil
    }
    
    func testIfTheDatabaseIsAddingCorrectly() {
        
        let database: HandlerDatabase = HandlerDatabase(config: Realm.Configuration(inMemoryIdentifier: "inMemory"))
        
        let json = """
            [
              {
                "Country": "Afghanistan",
                "Slug": "afghanistan",
                "ISO2": "AF"
              },
              {
                "Country": "Honduras",
                "Slug": "honduras",
                "ISO2": "HN"
              },
              {
                "Country": "Belgium",
                "Slug": "belgium",
                "ISO2": "BE"
              }
            ]
            """.data(using: .utf8)
        
        if let countries = worker?.decode(data: json!) {
            worker?.dataProviderList.add(countries: countries)
        }
        
        let allObjects = database.retrieveAllObjects(type: CountryInfoRealm.self) as! [CountryInfoRealm]
        
        XCTAssertEqual(allObjects.count, 3)
        XCTAssertEqual(allObjects[0].slug, "afghanistan")
        XCTAssertEqual(allObjects[1].slug, "honduras")
        XCTAssertEqual(allObjects[2].slug, "belgium")
    }
}
