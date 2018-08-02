//
//  Double+Extensions.swift
//  bitcoin-ticker
//
//  Created by Jemimah Beryl M. Sai on 02/08/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import Foundation

extension Double {
    var formatted: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
