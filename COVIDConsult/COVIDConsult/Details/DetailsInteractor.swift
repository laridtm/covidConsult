//
//  DetailsViewInteractor.swift
//  COVIDConsult
//
//  Created by Vitor Costa on 09/06/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import UIKit

protocol DetailsInteractorProtocol {
    func onViewLoad()
}

class DetailsInteractor: DetailsInteractorProtocol {
    var worker: DetailsWorkerProtocol?
    var presenter: DetailsPresenterProtocol?
    private var countryName: String
    
    init(worker: DetailsWorkerProtocol?, presenter: DetailsPresenterProtocol?, countryName: String) {
        self.worker = worker
        self.presenter = presenter
        self.countryName = countryName
    }
    
    func onViewLoad() {
        worker?.get(urlString: makeURL()) { countries in
            guard let lastInfo = countries.last else { return }
            self.presenter?.show(country: lastInfo)
        }
    }
    
    private func makeURL() -> String {
        return "https://api.covid19api.com/live/country/\(countryName)/status/confirmed"
    }
}
