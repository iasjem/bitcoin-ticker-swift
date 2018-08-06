//
//  ExchangeRate.swift
//  bitcoin-ticker
//
//  Created by Jemimah Beryl M. Sai on 31/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import Foundation
import Moya

struct Currency {
    var currencyCode: String
    var marketPrice: Double
    var currencySymbol: String
    
    init (code: String, marketPrice: Double, symbol: String) {
        self.currencyCode = code
        self.marketPrice = marketPrice
        self.currencySymbol = symbol
    }
}
