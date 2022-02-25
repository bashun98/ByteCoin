//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Евгений Башун on 13.02.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let rate: Double
    var rateString: String {
        String(format: "%.2f", rate)
    }
    
    init(with data: CoinData) {
        rate = data.rate
    }
}
