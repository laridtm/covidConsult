//
//  DetailsViewWorker.swift
//  COVIDConsult
//
//  Created by Vitor Costa on 10/06/20.
//  Copyright © 2020 Involves. All rights reserved.
//

import UIKit

protocol DetailsWorkerProtocol {
    var dataProvider: DetailsDataProviderProtocol? { get }
    func get(urlString: String, completion: @escaping([Country]) -> ())
    func decode(data: Data) -> [Country]?
}

class DetailsWorker: DetailsWorkerProtocol {
    var dataProvider: DetailsDataProviderProtocol?
    private let httpClient = HTTPClient()
    
    init(dataProvider: DetailsDataProviderProtocol?) {
        self.dataProvider = dataProvider
    }
    
    func get(urlString: String, completion: @escaping([Country]) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        httpClient.get(url: url) { result in
            switch result {
            case .failure:
                break
            case .success(let data):
                guard let countries = self.decode(data: data) else { return }
                self.dataProvider?.add(countries: countries)
                completion(countries)
                break
            }
        }
    }
    
    func decode(data: Data) -> [Country]? {
        return try? JSONDecoder().decode([Country].self, from: data)
    }
}
