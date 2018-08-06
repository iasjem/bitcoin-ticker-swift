//
//  CurrencyService.swift
//  bitcoin-ticker
//
//  Created by Jemimah Beryl M. Sai on 31/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import Moya
import SwiftyJSON
import RxSwift

class CurrencyService {
    
    // MARK: Initializers
    
    static let sharedInstance = CurrencyService()
    var currency = [Currency]()
    var btcCurrency = ""
    private let provider = MoyaProvider<ExchangeRatesAPI>()
    
    // MARK: Getters
    
    func retrieveData(completion: @escaping (_ completion: Bool) -> ()) {
        provider.request(.getRates) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                self.setCurrencyData(data: data)
                completion(true)
            case let .failure(error):
                print("error: \(error)")
                completion(false)
            }
        }
    }
    
    func getBTCData(code: String, price: Double, completion: @escaping (_ completion: Bool) -> ()) {
        let provider = MoyaProvider<ExchangeRatesAPI>()
        provider.request(.convertRateToBTC(currencyCode: code, marketPrice: price)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                self.setBTCData(data: data)
                completion(true)
            case let .failure(error):
                print("error: \(error)")
                completion(false)
            }
        }
    }
    
    // MARK: Setters
    
    func setCurrencyData(data: Data) {
        let json = JSON(data)
        for code in CurrencyCode.values {
            guard let currencyCode = json[code.rawValue].dictionaryObject else { return }
            guard let lastPrice = currencyCode["last"] as? Double else {  return  }
            guard let currencySymbol = currencyCode["symbol"] as? String else {   return  }
            self.currency.append(Currency(code: code.rawValue, marketPrice: lastPrice, symbol: currencySymbol))
        }
    }
    
    func setBTCData(data: Data) {
        let btc = String(data: data, encoding: .utf8)!
        btcCurrency = btc
    }
    
    // MARK: Helpers
    
    func clearData() {
        currency.removeAll()
        btcCurrency = ""
    }
}
