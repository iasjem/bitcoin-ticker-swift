//
//  CurrencyService.swift
//  bitcoin-ticker
//
//  Created by Jemimah Beryl M. Sai on 31/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import Moya
import SwiftyJSON

class CurrencyService {
    
    static let sharedInstance = CurrencyService()

    var currency = [Currency]()
    private let provider = MoyaProvider<ExchangeRatesAPI>()
    
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
    
    func setCurrencyData(data: Data) {
        let json = JSON(data)
        for code in CurrencyCode.values {
            guard let currencyCode = json[code.rawValue].dictionaryObject else { return }
            guard let lastPrice = currencyCode["last"] as? Double else {  return  }
            guard let currencySymbol = currencyCode["symbol"] as? String else {   return  }
            currency.append(Currency(code: code.rawValue, marketPrice: lastPrice, symbol: currencySymbol))
        }
    }
    
    func clearData() {
        currency.removeAll()
    }
}
