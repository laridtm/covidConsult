//
//  DetailsPresenter.swift
//  COVIDConsult
//
//  Created by Vitor Costa on 06/07/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import Foundation

protocol DetailsPresenterProtocol {
    var view: DetailsViewProtocol? { get set }
    func show(country: Country)
}

class DetailsPresenter: DetailsPresenterProtocol {
    var view: DetailsViewProtocol?
    
    init(view: DetailsViewProtocol) {
        self.view = view
    }
    
    func show(country: Country) {
        view?.show(country: country)
    }
}
