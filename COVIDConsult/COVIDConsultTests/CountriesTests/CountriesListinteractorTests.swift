//
//  CountriesListinteractorTests.swift
//  COVIDConsultTests
//
//  Created by Larissa Diniz  on 30/06/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import XCTest
@testable import COVIDConsult
import RealmSwift

class CountriesListInteractorTests: XCTestCase {
    
    var worker: MockCountriesListWorker?
    var interactor: CountriesListInteractorProtocol?
    var presenter: CountriesListPresentable?
    var controller: MockCountriesListViewController?
    
    override func setUp() {
        super.setUp()
        controller = MockCountriesListViewController()
        if let controller = controller {
            presenter = CountriesListPresenter(view: controller)
        }
        if let presenter = presenter {
            worker = MockCountriesListWorker()
            if let worker = worker {
                interactor = CountriesListInteractor(presenter: presenter, worker: worker)
            }
        }
    }
    
    override func tearDown() {
        super.tearDown()
        presenter = nil
        controller = nil
        worker = nil
        interactor = nil
    }
    
    func testIfTheInteractorIsCallingWorker() {
        interactor?.onViewLoad() 
        if let worker = worker {
            XCTAssertTrue(worker.getWasCalled)
            XCTAssertTrue(worker.decodeWasCalled)
        }
        
    }
    
    func testIfTheInteractorIsCallingSearchCountry() {
        interactor?.onSearchCountry(term: "testSearch")
        if let worker = worker {
            XCTAssertTrue(worker.searchCountryWasCalled)
        }
    }
}

class MockCountriesListWorker: CountriesListWorkerProtocol {
    
    var dataProviderList = CountriesListDataProvider(config: Realm.Configuration(inMemoryIdentifier: "inMemory"))
    var getWasCalled = false
    var decodeWasCalled = false
    var searchCountryWasCalled = false
    
    func get(url: String, completion: @escaping (([CountryInfo]) -> Void)) {
        getWasCalled = true
        if let json = "[]".data(using: .utf8) {
            let result = self.decode(data: json)
            if let result = result {
                completion(result)
            }
        }
    }
    
    func decode(data: Data) -> [CountryInfo]? {
        decodeWasCalled = true
        return [CountryInfo]()
    }
    
    func searchCountry(countries: [CountryInfo], term: String) -> [CountryInfo] {
        searchCountryWasCalled = true
        return [CountryInfo]()
    }
}

class MockCountriesListViewController: CountriesView {
    var showWasCalled = false
    
    func show(items: [CountryInfo]) {
        showWasCalled = true
    }
}
