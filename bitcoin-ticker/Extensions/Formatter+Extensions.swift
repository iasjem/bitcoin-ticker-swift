//
//  Formatter+Extensions.swift
//  bitcoin-ticker
//
//  Created by Jemimah Beryl M. Sai on 02/08/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import Foundation

extension Formatter{
    static var withSeparator: NumberFormatter {
       let formatter = NumberFormatter()
       formatter.groupingSeparator = ","
       formatter.numberStyle = .decimal
       return formatter
    }
}
