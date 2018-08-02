//
//  CurrencyCell.swift
//  bitcoin-ticker
//
//  Created by Jemimah Beryl M. Sai on 31/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {

    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var currencySymbolLabel: UILabel!
    @IBOutlet weak var marketPriceLabel: UILabel!
    @IBOutlet weak var BTCLabel: UILabel!
    
    func configureCell(code: String, symbol: String, price: Double) {
        currencyCodeLabel.text = code
        currencySymbolLabel.text = symbol
        marketPriceLabel.text = price.formatted
        BTCLabel.text = String(0)
    }
}
