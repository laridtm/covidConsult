//
//  CountriesListPresenter.swift
//  COVIDConsultTests
//
//  Created by Larissa Diniz  on 02/07/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import Foundation
import XCTest
@testable import COVIDConsult

class CountriesListPresenterTests: XCTestCase {
    
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
    
    func testIfThePresenterIsCallingTheView() {
        interactor?.onViewLoad()
        if let controller = controller {
            XCTAssertTrue(controller.showWasCalled)
        }
        
    }
}
