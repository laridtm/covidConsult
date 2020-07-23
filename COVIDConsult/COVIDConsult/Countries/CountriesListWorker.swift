//
//  CountriesListWorker.swift
//  COVIDConsult
//
//  Created by Larissa Diniz  on 12/06/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import Foundation

protocol CountriesListWorkerProtocol: class {
    func get(url: String, completion: @escaping (([CountryInfo]) -> Void))
    func decode(data: Data) -> [CountryInfo]?
    var dataProviderList: CountriesListDataProvider { get }
    func searchCountry(countries: [CountryInfo], term: String) -> [CountryInfo]
}

class CountriesListWorker: CountriesListWorkerProtocol {
    
    let dataProviderList: CountriesListDataProvider
    var httpClient = HTTPClient()
    
    init(dataProvider: CountriesListDataProvider) {
        self.dataProviderList = dataProvider
    }
    
    func get(url: String, completion: @escaping (([CountryInfo]) -> Void)) {
        if let url = URL(string: url) {
            httpClient.get(url: url) { result -> Void in
                switch result {
                case .failure:
                    break
                case .success(let data):
                    if let countries = self.decode(data: data){
                        self.dataProviderList.add(countries: countries)
                        completion(countries)
                    }
                    break
                }
            }
        }
    }
    
    func decode(data: Data) -> [CountryInfo]? {
        let countries = try? JSONDecoder().decode([CountryInfo].self, from: data)
        return countries
    }
    
    func searchCountry(countries: [CountryInfo], term: String) -> [CountryInfo] {
        var responseCountries = countries.filter { $0.country.lowercased().contains(term.lowercased()) }

        if (term.isEmpty) {
            responseCountries = countries
        }

        return responseCountries
    }
}

