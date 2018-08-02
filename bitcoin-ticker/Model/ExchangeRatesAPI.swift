//
//  ExchangeRatesAPI.swift
//  bitcoin-ticker
//
//  Created by Jemimah Beryl M. Sai on 02/08/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import Moya

enum ExchangeRatesAPI {
    case getRates
    case convertRateToBTC(currencyCode: String, marketPrice: Double)
}

// MARK: TargetType Protocol Implementation

extension ExchangeRatesAPI: TargetType {
    var baseURL: URL {  return URL(string: "https://blockchain.info/")!  }
    var path: String {
        switch self {
        case .getRates:
            return "ticker"
        case .convertRateToBTC(let code, let price):
            return "tobtc?currency=\(code)&value=\(price)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getRates, .convertRateToBTC(_ , _):
            return .get
        }
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    var task: Task {
        switch self {
        case .getRates, .convertRateToBTC(_ , _):
            return .requestPlain
        }
    }
}
