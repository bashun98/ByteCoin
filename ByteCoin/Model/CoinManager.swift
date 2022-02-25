//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDescription {
    func fetchExchangeData(from currency: String, completion: @escaping (CoinModel)->())
    var currencyArray: [String] { get }
}

struct CoinManager: CoinManagerDescription {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    static let apiKey = "103B972D-3FCA-412B-AE6E-391DD9C25C70"
    
    let currencyArray = ["Select currency","AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    func fetchExchangeData(from currency: String, completion: @escaping (CoinModel) -> ()) {
        let urlString = baseURL + "/\(currency)" + "?apikey=\(Self.apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(CoinData.self, from: data)
                    let coinModel = CoinModel(with: decodedData)
                    completion(coinModel)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    
}
