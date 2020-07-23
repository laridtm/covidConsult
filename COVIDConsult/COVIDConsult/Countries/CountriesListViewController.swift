//
//  ListViewController.swift
//  COVIDConsult
//
//  Created by Larissa Diniz  on 04/06/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

protocol CountriesView: class {
    func show(items: [CountryInfo])
}

class CountriesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBarBottomConstraint: NSLayoutConstraint!
    
    var countries: [CountryInfo] = []
    var interactor: CountriesListInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CountryViewCell",bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "CountryCell")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        mapView.delegate = self
        
        hideTableView()
        interactor?.onViewLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = countries[indexPath.row].country
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as? CountryViewCell {
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.setCountryName(name: country)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countrySelected: CountryInfo? = countries[indexPath.row]
        if let countryDetails = countrySelected {
            let controllerDetails = DetailsViewController(nibName: "DetailsView", bundle: nil)
            let presenterDetails = DetailsPresenter(view: controllerDetails)
            let dataProviderDetails = DetailsDataProvider(config: Realm.Configuration())
            let workerDetails = DetailsWorker(dataProvider: dataProviderDetails)
            let interactorDetails = DetailsInteractor(worker: workerDetails, presenter: presenterDetails, countryName: countryDetails.country)
            controllerDetails.interactor = interactorDetails
            self.navigationController?.present(controllerDetails, animated: true, completion: nil)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        interactor?.onSearchCountry(term: searchBar.text ?? "")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showTableView()
    }
    
    func hideTableView() {
        tableView.isHidden = true
    }
    
    func showTableView() {
        if tableView.isHidden {
            UIView.animate(withDuration: 3.0) {
                self.mapViewBottomConstraint.constant = 600
                self.searchBar.frame.size.height = 536
//                self.searchBarBottomConstraint.constant = 536
//                self.tableView.isHidden = false
            }
        } else if tableView.isHidden == false {
            UIView.animate(withDuration: 3.0) {
                self.mapViewBottomConstraint.constant = 180
//                self.searchBarBottomConstraint.constant = 136
                self.tableView.isHidden = true
            }
        }
    }
}

extension CountriesListViewController: CountriesView {
    
    func show(items: [CountryInfo]) {
        self.countries = items
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
