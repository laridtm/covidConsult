//
//  DetailsViewController.swift
//  COVIDConsult
//
//  Created by Vitor Costa on 08/06/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import UIKit

protocol DetailsViewProtocol {
    var interactor: DetailsInteractorProtocol? { get set }
    func show(country: Country)
}

class DetailsViewController: UIViewController, DetailsViewProtocol {
    @IBOutlet weak var labelConfirmedCases: UILabel!
    @IBOutlet weak var labelDeathCases: UILabel!
    @IBOutlet weak var labelRecoveredCases: UILabel!
    @IBOutlet weak var labelActiveCases: UILabel!
    var interactor: DetailsInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.onViewLoad()
    }
    
    func show(country: Country) {
        DispatchQueue.main.async {
            self.labelConfirmedCases.text = "\(country.confirmed)"
            self.labelDeathCases.text = "\(country.deaths)"
            self.labelRecoveredCases.text = "\(country.recovered)"
            self.labelActiveCases.text = "\(country.active)"
        }
    }
}
