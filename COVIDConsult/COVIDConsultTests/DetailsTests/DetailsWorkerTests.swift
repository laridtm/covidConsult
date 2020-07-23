//
//  DetailsWorkerTests.swift
//  COVIDConsultTests
//
//  Created by Vitor Costa on 12/06/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import XCTest
@testable import COVIDConsult

class DetailsWorkerTests: XCTestCase {
    var countries: [Country]?
    var worker: DetailsWorkerProtocol?
    
    override func setUp() {
        super.setUp()
        worker = DetailsWorker(dataProvider: MockDetailsDataProvider())
    }
    
    override func tearDown() {
        countries = nil
        worker = nil
        super.tearDown()
    }
    
    func testIfDecodeWasSuccesful() {
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
        "Country": "South Africa",
        "CountryCode": "ZA",
        "Province": "",
        "City": "",
        "CityCode": "",
        "Lat": "-30.56",
        "Lon": "22.94",
        "Confirmed": 2272,
        "Deaths": 27,
        "Recovered": 410,
        "Active": 1835,
        "Date": "2020-04-14T00:00:00Z"
        }
        ]
        """.data(using: .utf8) else { return }
        countries = worker?.decode(data: data)
        XCTAssertNotNil(countries)
    }
}

class MockDetailsDataProvider: DetailsDataProviderProtocol {
    func add(countries: [Country]) {
    }
}
