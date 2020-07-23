//
//  DetailsPresenterTests.swift
//  COVIDConsultTests
//
//  Created by Vitor Costa on 06/07/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import XCTest
@testable import COVIDConsult

class DetailsPresenterTests: XCTestCase {
    var view: MockDetailsViewController?
    var presenter: DetailsPresenterProtocol?
    
    override func setUp() {
        view = MockDetailsViewController()
        guard let view = view else { return }
        presenter = DetailsPresenter(view: view)
    }

    override func tearDown() {
        view = nil
        presenter = nil
    }
    
    func testIfPresenterIsCalledFuncShowOfViewController() {
        presenter?.show(country: Country(country: "Brazil", countryCode: "BR", province: "", city: "Brasilia", cityCode: "", lat: "", lon: "", confirmed: 15, deaths: 156, recovered: 12151, active: 146, date: ""))
        guard let view = view else { return }
        XCTAssertTrue(view.showWasCalled)
    }
}

class MockDetailsViewController: DetailsViewProtocol {
    var interactor: DetailsInteractorProtocol?
    var showWasCalled = false
    
    func show(country: Country) {
        showWasCalled = true
    }
}
