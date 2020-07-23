//
//  DetailsInteractorTests.swift
//  COVIDConsultTests
//
//  Created by Vitor Costa on 06/07/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import XCTest
@testable import COVIDConsult

class DetailsInteractorTests: XCTestCase {
    var interactor: DetailsInteractor?
    var presenter: MockDetailsPresenter?
    var worker: MockDetailsWorker?
    
    override func setUp() {
        worker = MockDetailsWorker()
        presenter = MockDetailsPresenter()
        interactor = DetailsInteractor(worker: worker, presenter: presenter, countryName: "Brazil")
    }

    override func tearDown() {
        worker = nil
        presenter = nil
        interactor = nil
    }
    
    func testIfInteractorIsCalledFuncShowOfPresenter() {
        interactor?.onViewLoad()
        guard let presenter = presenter else { return }
        XCTAssertTrue(presenter.showWasCalled)
    }
    
    func testIfFuncMakeURLCreatesTheURLCorrectly() {
        interactor?.onViewLoad()
        XCTAssertEqual(worker?.url, "https://api.covid19api.com/live/country/Brazil/status/confirmed")
    }
}

class MockDetailsPresenter: DetailsPresenterProtocol {
    var view: DetailsViewProtocol?
    var showWasCalled = false
    
    func show(country: Country) {
        showWasCalled = true
    }
}

class MockDetailsWorker: DetailsWorkerProtocol {
    var dataProvider: DetailsDataProviderProtocol?
    var getWasCalled = false
    var decodeWasCalled = false
    var url = ""
    
    func get(urlString: String, completion: @escaping ([Country]) -> ()) {
        url = urlString
        getWasCalled = true
        let country = Country(country: "Brazil", countryCode: "BR", province: "", city: "Brasilia", cityCode: "", lat: "", lon: "", confirmed: 15, deaths: 156, recovered: 12151, active: 146, date: "")
        let countries = [country]
        completion(countries)
    }
    
    func decode(data: Data) -> [Country]? {
        decodeWasCalled = true
        return [Country]()
    }
}
