//
//  CountriesListPresenter.swift
//  COVIDConsult
//
//  Created by Larissa Diniz  on 02/07/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import Foundation

protocol CountriesListPresentable: class {
    var view: CountriesView? { get }
    func showItems(items: [CountryInfo])
}

final class CountriesListPresenter: CountriesListPresentable {
    
    internal weak var view: CountriesView?
    
    init(view: CountriesView) {
        self.view = view
    }
    
    func showItems(items: [CountryInfo]) {
        view?.show(items: items)
    }

}
