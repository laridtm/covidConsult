//
//  COVIDConsultTests.swift
//  COVIDConsultTests
//
//  Created by Larissa Diniz  on 03/06/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import XCTest
@testable import COVIDConsult
import RealmSwift

class CountriesListWorkerTests: XCTestCase {
    
    var worker: CountriesListWorkerProtocol?
    var dataProvider: CountriesListDataProvider?
    var countries: [CountryInfo]?
    
    override func setUp() {
        super.setUp()
        dataProvider = CountriesListDataProvider(config: Realm.Configuration(inMemoryIdentifier: "inMemory"))
        if let dataProvider = dataProvider {
            worker = CountriesListWorker(dataProvider: dataProvider)
        }
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
        
        countries = worker?.decode(data: json!)
    }
    
    override func tearDown() {
        super.tearDown()
        worker = nil
        countries = nil
    }
    
    func testIfTheDecoderWasSuccessful() {
        XCTAssertEqual(countries!.count, 3)
    }
    
    func testIfTheSearchIsCorrect() {
        
        var countriesSearch: [CountryInfo]?
        
        countriesSearch = worker?.searchCountry(countries: countries!, term: "Afghanistan")
        
        XCTAssertEqual(countriesSearch!.count, 1)
        XCTAssertEqual(countriesSearch![0].country, "Afghanistan")
    }
    
}
