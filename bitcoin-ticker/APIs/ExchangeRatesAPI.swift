//
//  ExchangeRatesAPI.swift
//  bitcoin-ticker
//
//  Created by Jemimah Beryl M. Sai on 02/08/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import Foundation
import Moya
import RxSwift

// MARK: Enumeration

enum ExchangeRatesAPI {
    case getRates
    case convertRateToBTC(currencyCode: String, marketPrice: Double)
}

// MARK: TargetType Protocol Implementation

extension ExchangeRatesAPI: TargetType {
    var baseURL: URL {  return URL(string: "https://blockchain.info")!  }
    
    var path: String {
        switch self {
        case .getRates:
            return "/ticker"
        case .convertRateToBTC(_, _):
            return "/tobtc"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRates, .convertRateToBTC:
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
        case .getRates:
            return .requestPlain
        case let .convertRateToBTC(code, price):
            return .requestParameters(parameters: ["currency": code, "value": price], encoding: URLEncoding.queryString)
        }
    }
}
