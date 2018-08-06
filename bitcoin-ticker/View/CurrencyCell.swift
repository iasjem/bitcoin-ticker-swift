//
//  CurrencyCell.swift
//  bitcoin-ticker
//
//  Created by Jemimah Beryl M. Sai on 31/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import UIKit
import Moya
import Alamofire

class CurrencyCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var marketPriceLabel: UILabel!
    
    // MARK: Helpers
    
    func configureCell(code: String, symbol: String, price: Double) {
        currencyCodeLabel.text = code
        marketPriceLabel.text = "\(symbol) \(price.formatted)"
    }
}
