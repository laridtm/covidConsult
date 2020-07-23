//
//  CountriesListInteractor.swift
//  COVIDConsultTests
//
//  Created by Larissa Diniz  on 29/06/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import Foundation

protocol CountriesListInteractorProtocol {
    var url: String { get set }
    func onViewLoad()
    func onSearchCountry(term: String)
}

class CountriesListInteractor: CountriesListInteractorProtocol {
    private let presenter: CountriesListPresentable
    private let worker: CountriesListWorkerProtocol
    var url: String = "https://api.covid19api.com/countries"
    private var items: [CountryInfo]
    
    init(presenter: CountriesListPresentable, worker: CountriesListWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
        self.items = []
    }
    
    func onViewLoad() {
        worker.get(url: url) { items in
            self.items = items
            self.presenter.showItems(items: items)
        }
    }
    
    func onSearchCountry(term: String) {
        let searchResult = worker.searchCountry(countries: items, term: term)
        self.presenter.showItems(items: searchResult)
    }
}
